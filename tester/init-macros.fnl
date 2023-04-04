(fn splice [into forms]
  (each [_ form (ipairs forms)]
    (table.insert into form)))

(fn test-fn [id args-or-body ...]
  (let [(args body) (if (sequence? args-or-body)
                      (values args-or-body [...])
                      (values [] [args-or-body ...]))]
    (doto (list)
          (splice [`fn id args])
          (splice body)
          (splice [`nil]))))

{: test-fn}
