# Fawkss — The [ig]noble CSS preprocessor [![MIT License][license-svg]][license-url]

Fawkss [fɔːks] is a simple CSS preprocessor built as a single AWK (nawk/gawk/mawk) script. Syntactically, it borrows as much as possible from the SASS language, for convenience and familiarity.

This is more of a fun project than a production-ready piece of software, though it may find some use for people needing simple additions to CSS without pulling in the massive ecosystem that comes with Less.js/SASS etc.

## Status

Currently, the following SASS features are implemented, in varying degrees:

### C99/C++-style comments

Lines that contain comments using the `//` syntax are removed from the final output, and are useful for including commentary that should otherwise not be available to end-users.

Comments using the `/* */` syntax are not handled, and remain intact in the final output.

### Variables

Variables can be defined and used with the following syntax:

```scss
$variable-name: 10px;
width: $variable-name;
```

All variables are defined in the global scope, and cannot be used before definition. Using an undefined variable is a fatal error, and halts execution. Variable names can contain alphanumeric characters, as well as underscore and hyphen characters, and are always prefixed with a dollar sign.

Variables must be appear on their own line, and cannot be mixed with other declarations. Redefining a variable overrides its previous value, with no warning message emitted.

### Imports

CSS import declarations are extended for concatenating SCSS files together transparently. For a file `common/_colors.scss`, the following declarations are equivalent:

```scss
@import "common/colors";
@import "common/colors.scss";
@import "common/_colors";
@import "common_colors.scss";
```

Unlike SASS, files with leading underscores are not handled especially as partials.

### Mixins

Mixin support is currently minimal, with parameters (including default values) and nested mixins handled.

Features such as variadic parameters and mixins with parent selectors are forthcoming.

## Roadmap

It is intended that the script never balloons to more than ~1000 lines of code. I'm trying to tackle the most important features yet and see how well they fit within the AWK mindset.

That being said, I do not plan to implement any context-sensitive functionality (such as nesting etc.), which may be nigh-impossible in AWK anyways. Consider it a feature.

## Testing & Documentation

A `Makefile` is provided for running tests and producing documentation for Fawkss. Run `make help` in the project root for more information.

A full test-suite is provided (depending only on `make` and `awk`), which should serve as a good example of the existing feature-set.

## License

All code in this repository is covered by the terms of the MIT License, the full text of which can be found in the LICENSE file.

[license-url]: https://github.com/deuill/go-php/blob/master/LICENSE
[license-svg]: https://img.shields.io/badge/license-MIT-blue.svg
