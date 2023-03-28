# fnlcov

Attempt to adapt LuaCov to Fennel sources.

Basically, LuaCov works out-of-the-box (just load `luacov`), but it requires
`--correlate` option set on fennel to correctly report source lines covered.
`fnlcov.fnl` module attempts to replace fennel searcher with one that has
`correlate` option set.

Additionally, custom reporter (`"fnlcov"`, located in `luacov.reporter`
namespace) must be used. See example `.luacov` file.

For reports to be correctly generated with Fennel sources files,
`fnlcov.runner` should be used. It is a simple wrapper around LuaCov runner,
but invoked from Fennel, so it is aware of Fennel sources.

Note that LuaCov is based on information from Lua `debug` package and not all
lines may be marked as covered. This is not an issue with Fennel.

You can use CLuaCov to get better coverage results.

## Dependencies
- luacov
- cluacov (optional, but recommended)

## Development

### Dependencies
- `seeds.tester`

### Tests with coverage quick run
- run tests
```bash
fennel --add-macro-path "../../seeds/?/init-macros.fnl" \
       --add-fennel-path "./src/?.fnl" \
       --add-package-path "./src/?.lua" \
       --load fnlcov.fnl \
       ../tester/runner'
```
- generate coverage report (if `runreport = false`)
```bash
fennel fnlcov/runner.fnl
```
