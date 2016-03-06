# ------------------
# Makefile for Fawks
# ------------------

# Run `make help` for information on available actions.

# --------------------
# Variable definitions
# --------------------

# Default name for Fawkss executable.
FAWKSS = $(CURDIR)/fawkss

# Diff executable to use, prefer `colordiff` if installed.
DIFF = $(shell which colordiff || which diff)
TMPPID = $(shell echo $$PPID)

# Test files to execute.
TESTS ?= $(shell find tests/*.scss)

# Color & style definitions.
BOLD      = \033[1m
UNDERLINE = \033[4m
RED       = \033[31m
GREEN     = \033[32m
BLUE      = \033[36m
RESET     = \033[0m

# ----------------
# Other directives
# ----------------

# Make `help` be the default action when no arguments are passed to `make`.
.DEFAULT_GOAL = help
.PHONY: $(TESTS) test help

# Awk script for extracting Fawkss documentation as Markdown.
define EXTRACT_MARKDOWN
/^(#|# .*)$$/ {
	if (f==1) {f=0; printf "```\n\n"}
	print substr($$0, 3)
}
/^[^#]/ {
	if (f==0) {f=1; printf "\n```awk\n"}
	print
}
!NF {
	print
}
END {
	if (f==1) {printf "```\n"}
}
endef
export EXTRACT_MARKDOWN

# ----------------
# Rule definitions
# ----------------

## Build documentation from source file in Markdown format.
doc:
	@awk "$$EXTRACT_MARKDOWN" "$(FAWKSS)"

## Execute test suite, accepts list of specific files to run.
test: test-before $(TESTS) test-after

test-before:
	@printf ">> $(BOLD)Executing tests...$(RESET)\n"

test-after:
	@printf ">> $(BOLD)Finished executing tests.$(RESET)\n"

$(TESTS):
	@awk "/--- TEST ---/ {f=1;next} /--- EXPECTED ---/ {exit} f" $@ >> $@.test.$(TMPPID)
	@awk "/--- EXPECTED ---/ {f=1;next} /--- END ---/ {exit} f" $@ >> $@.expected.$(TMPPID)

	@$(FAWKSS) $@.test.$(TMPPID) > $@.actual.$(TMPPID)
	@printf ">> $(BOLD)Testing file '$@'...$(RESET) "

	@result=$$($(DIFF) -ud $@.actual.$(TMPPID) $@.expected.$(TMPPID) | tail -n +3); \
	if [ -z "$${result}" ]; then                                                    \
		printf "$(GREEN)OK$(RESET)\n";                                              \
	else                                                                            \
		printf "$(RED)FAIL$(RESET)\n";                                              \
		echo "$${result}";                                                          \
	fi                                                                              \

	@rm -f $@.test.$(TMPPID) $@.expected.$(TMPPID) $@.actual.$(TMPPID)

## Show usage information for this Makefile.
help:
	@printf "Fawkss — The simple CSS preprocessor.\n\n"
	@printf "$(UNDERLINE)Available Tasks$(RESET)\n\n"
	@awk -F ':|##' '/^##/ {c=$$2; getline; printf "$(BLUE)%10s$(RESET) %s\n", $$1, c}' $(MAKEFILE_LIST)
	@printf "\n"