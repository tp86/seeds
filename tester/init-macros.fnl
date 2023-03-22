(fn splice [into forms]
  (each [_ form (ipairs forms)]
    (table.insert into form)))

(fn test-fn [id ...]
  (doto `()
        (splice [`fn id []])
        (splice [...])
        (splice [`nil])))

{: test-fn}
