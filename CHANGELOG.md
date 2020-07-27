# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.4] - 2020-07-27

### Fixed

- Bad build state for update cmd [#27]

### Added

- AUR package support [#26]
- Default command to list [#30]

### Changed

- Replace `Data.Duration` by own duration with tests [#24]

## [0.4.3] - 2020-03-11

### Added

- Init basic bash completion (commands, ids and tags) [#18]

## [0.4.2] - 2020-03-07

### Changed

- Remove secs and millis from queries [#23]
- All screenshots

### Fixed

- Bad wtime ordering [#22]
- Make install script more compatible by replacing `[[]]` with `[]`

## [0.4.1] - 2020-02-23

### Added

- `--more` option for worktime query

### Fixed

- `--json` output for worktime command

## [0.4.0] - 2020-01-11

### Added

- Upgrade command [#10]
- Add `status` command for UI integration
- Add `undone` command to unmark as done tasks [#20]

### Changed

- Shorter aliases
- Show command (UI) [#17]
- `worktime` command (group by ids) [#11]
- **[BREAKING]** Commands names + aliases

## [0.3.3] - 2020-01-01

### Added

- Colors [#4]

## [0.3.2] - 2019-12-30

### Added

- Refactor parsec exprs with `(<++)`
- Allow for batch processing of tasks [#13]

## [0.3.1] - 2019-12-28

### Fixed

- Active approx label (from `in ...` to `... ago`)

## [0.3.0] - 2019-12-28

### Added

- Due time [#9]

### Changed

- Make `+` optional in `context` and `worktime` commands [#16]

### Fixed

- Remove `print` [#15]

## [0.2.2] - 2019-12-22

### Added

- Worktime date range [#9]
- Due time [#9]

### Fixed

- Hyphen issue in desc [#12]

## [0.2.1] - 2019-12-08

### Added

- Add basic help command [#3]
- Add version command

### Changed

- Replace active ✔ by the elapsed time [#8]

### Fixed

- Delete command [#1]
- Worktime doesn't take in consideration the context [#2]

## [0.2.0] - 2019-12-01

### Added 

- Changelog
- New syntax to remove tags: `-tag` [#6]

### Changed

- **[BREAKING]** New parser introduced, based on parser combinators ([ReadP](https://hackage.haskell.org/package/base-4.12.0.0/docs/Text-ParserCombinators-ReadP.html)). Events have been impacted (simplified), so the previous store is not compatible anymore. You can upgrade it with this command: `sed -i -E 's/True |False |\+//g' ~/.config/unfog/store`

### Fixed 

- Create config dir if not exists [#5]

## [0.1.4] - 2019-11-26

### Added

- Installation script

### Changed

- Binaries compression (tar.gz)

## [0.1.3] - 2019-11-26

### Changed

- Build optimization

## [0.1.2] - 2019-11-26

### Added

- Travis CI
- Cross-compilation to Linux, OSX and Windows

## [0.1.1] - 2019-11-24

### Changed

- Update README and LICENSE

## [0.1.0] - 2019-11-23

First release :tada:

### Added

- Linux binaries

[unreleased]: https://github.com/soywod/unfog.cli/compare/v0.4.4...HEAD
[0.4.4]: https://github.com/soywod/unfog.cli/compare/v0.4.3...v0.4.4
[0.4.3]: https://github.com/soywod/unfog.cli/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/soywod/unfog.cli/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/soywod/unfog.cli/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/soywod/unfog.cli/compare/v0.3.3...v0.4.0
[0.3.3]: https://github.com/soywod/unfog.cli/compare/v0.3.2...v0.3.3
[0.3.2]: https://github.com/soywod/unfog.cli/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/soywod/unfog.cli/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/soywod/unfog.cli/compare/v0.2.2...v0.3.0
[0.2.2]: https://github.com/soywod/unfog.cli/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/soywod/unfog.cli/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/soywod/unfog.cli/compare/v0.1.4...v0.2.0
[0.1.4]: https://github.com/soywod/unfog.cli/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/soywod/unfog.cli/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/soywod/unfog.cli/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/soywod/unfog.cli/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/soywod/unfog.cli/releases/tag/v0.1.0

[#1]: https://github.com/soywod/unfog.cli/issues/1
[#2]: https://github.com/soywod/unfog.cli/issues/2
[#3]: https://github.com/soywod/unfog.cli/issues/3
[#4]: https://github.com/soywod/unfog.cli/issues/4
[#5]: https://github.com/soywod/unfog.cli/issues/5
[#6]: https://github.com/soywod/unfog.cli/issues/6
[#8]: https://github.com/soywod/unfog.cli/issues/8
[#9]: https://github.com/soywod/unfog.cli/issues/9
[#10]: https://github.com/soywod/unfog.cli/issues/10
[#11]: https://github.com/soywod/unfog.cli/issues/11
[#12]: https://github.com/soywod/unfog.cli/issues/12
[#13]: https://github.com/soywod/unfog.cli/issues/13
[#15]: https://github.com/soywod/unfog.cli/issues/15
[#16]: https://github.com/soywod/unfog.cli/issues/16
[#18]: https://github.com/soywod/unfog.cli/issues/18
[#20]: https://github.com/soywod/unfog.cli/issues/20
[#22]: https://github.com/soywod/unfog.cli/issues/22
[#23]: https://github.com/soywod/unfog.cli/issues/23
[#24]: https://github.com/soywod/unfog.cli/issues/24
[#26]: https://github.com/soywod/unfog.cli/issues/26
[#27]: https://github.com/soywod/unfog.cli/issues/27
[#30]: https://github.com/soywod/unfog.cli/issues/30
