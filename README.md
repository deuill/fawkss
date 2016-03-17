# Fawkss — The [ig]noble CSS preprocessor [![MIT License][license-svg]][license-url]

Fawkss [fɔːks] is a simple CSS preprocessor built as a single AWK (nawk/gawk/mawk) script. Syntactically, it borrows as much as possible from the SASS language, for convenience and familiarity.

This is more of a fun project than a production-ready piece of software, though it may find some use for people needing simple additions to CSS without pulling in the massive ecosystem that comes with Less.js/SASS etc.

## Status

Currently, the following features are implemented:

  * C99/C++-style comments (i.e. `// This is a comment`)
  * Variables
  * Includes (i.e. `@include "colors/common`)

A full test-suite is provided (depending only on `make` and `awk`), which should serve as a good example of the existing feature-set.

## Roadmap

It is intended that the script never balloons to more than ~1000 lines of code. I'm trying to tackle the most important features yet and see how well they fit within the AWK mindset.

That being said, I do not plan to implement any context-sensitive functionality (such as nesting etc.), which may be nigh-impossible in AWK anyways. Consider it a feature.

## Testing & Documentation

A `Makefile` is provided for running tests and producing documentation for Fawkss. Run `make help` in the project root for more information.

## Are you kidding me?

Nope. I wouldn't suggest you actually use this for anything, though.

## License

All code in this repository is covered by the terms of the MIT License, the full text of which can be found in the LICENSE file.

[license-url]: https://github.com/deuill/go-php/blob/master/LICENSE
[license-svg]: https://img.shields.io/badge/license-MIT-blue.svg