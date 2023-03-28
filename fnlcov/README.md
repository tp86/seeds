# fnlcov

Attempt to adapt LuaCov to Fennel sources.

Basically, this works out-of-the-box (just load `luacov`), but it requires
`--correlate` option set on fennel to correctly report source lines covered.
`fnlcov.fnl` module attempts to replace fennel searcher with one that has
`correlate` option set.

Note that LuaCov is based on information from Lua `debug` package and not all
lines are marked as covered. This is not an issue with Fennel.

You can use CLuaCov to get better coverage results.

## Dependencies
- luacov

## Development

### Dependencies
- `seeds.tester`
