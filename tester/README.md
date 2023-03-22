# Tester

Simple test runner for Fennel.

## Dependencies
- [luaunit](https://github.com/bluebird75/luaunit)
- [lfs](https://github.com/lunarmodules/luafilesystem)

### Setup

Obtain dependencies and setup correct `package.path` and `package.cpath`.

## Usage

Simply run
```bash
fennel runner
```
or even (assuming paths are set correctly, see below)
```bash
./runner
```

Make sure you set correct paths for dependencies, e.g.
```bash
fennel --add-package-path lib/?.lua --add-package-cpath lib/?.so runner
```

Arguments starting with dash (`-`) are passed to Luaunit's runner. If Luaunit's
option requires an argument, you have to surround whole pair with double quotes
to treat it as single argument (e.g. `./runner "-x data"`). Arguments not
starting with dash are treated as paths for collecting tests (recursively). If
no paths are specified, tests are searched for in `test` directory. Test files
must be Fennel modules and match `*.fnl` pattern.

### Writing tests

Write test functions and tables as you would normally do with Luaunit. As
tester uses runSuiteByInstances method from Luaunit, you don't have to
put top-level tests in global scope and you don't have to start their names
with "test". You have to return table with test instances from your test
modules, though. Test method names defined inside table-based test instances
still have to start with "test".

Example test file:
```fennel
(local lu (require :luaunit))

(fn abc-1 []
  (lu.assertTrue true)
  nil)

{: abc-1}
```

Note that for correct reporting of failing line within test function, function
must return `nil`. In Fennel this means explicit ending function body with
`nil`. You can use `test-fn` macro for easier test writing.

Above example becomes (assuming `./?.fnl` in macro path):
```fennel
(local lu (require :luaunit))
(import-macros {: test-fn} :init-macros)

(test-fn abc-1
  (lu.assertTrue true))

{: abc-1}
```
