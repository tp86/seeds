(local lu (require :luaunit))
(import-macros {: test-fn} :tester)

(local {: func} (require :fnl.mod))

(test-fn func-test
  (lu.assertEquals [2] (func)))

{: func-test}
