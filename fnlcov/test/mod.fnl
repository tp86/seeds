(local lu (require :luaunit))
(import-macros {: test-fn} :tester)

(local {: func} (require :fnl.mod))

(test-fn fnl-test
  (lu.assertEquals [2] (func)))

(local {:func lua-func} (require :lua.mod))

(test-fn lua-test
  (lu.assertEquals [2] (lua-func)))

{: fnl-test
 : lua-test}
