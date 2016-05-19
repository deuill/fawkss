# Fawkss — The [ig]noble CSS preprocessor [![MIT License][license-svg]][license-url]

Fawkss [fɔːks] is a simple CSS preprocessor built as a single AWK (nawk/gawk/mawk) script. Syntactically, it borrows as much as possible from the SASS language, for convenience and familiarity.

This is more of a fun project than a production-ready piece of software, though it may find some use for people needing simple additions to CSS without pulling in the massive ecosystem that comes with Less.js/SASS etc.

## Status

Currently, the following SASS features are implemented, in varying degrees:

### C99/C++-style comments

Lines containing comments using the `//` syntax allow for including commentary that does not appear in the processed CSS output. Support for the common `/* */` syntax remains the same, and affected lines are not removed from the final output.

### Variables

Variables can be declared and used with the following syntax:

```scss
$variable-name: 10px;
width: $variable-name;
```

All variables are defined in the global scope, regardless of where they've been defined. Variable names can contain alphanumeric characters, as well as underscore and hyphen characters, and are always prefixed with a dollar sign.

Only one variable declaration can appear on a single line, though once defined, a variable can be used as many times as needed, including on the same line. Redeclaring a variable overrides its previous value.


### Imports

CSS import declarations are extended for including files transparently in the same output file. Imports reference files with the `.scss` extension, but will resolve to such files even if not specified in the import declaration. Thus, for a file of name `common/_colors.scss`, the following declarations are equivalent:

```scss
@import "common/colors"
@import "common/colors.scss"
@import "common/_colors"
@import "common_colors.scss"
```

Files with leading underscores are handled as partials with additional restrictions by SASS, though Fawkss makes no such distinctions.

### Mixins

Currently supported are mixins with optional parameters (including default values) and nested mixins. Features such as variadic parameters and mixins with parent selectors are forthcoming.

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
