(local lu (require :luaunit))
(import-macros {: test-fn} :tester)

(test-fn basic
  (lu.assertTrue true))

{: basic}
