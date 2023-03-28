(local luacov-reporter (require :luacov.reporter))
(local {: dofile} (require :fennel))

(local base luacov-reporter.DefaultReporter)

(local FnlReporter (setmetatable {} base))
(set FnlReporter.__index FnlReporter)

(fn FnlReporter.on_new_file [self filename]
  (set self._file-lines (with-open [file (io.open filename)]
                          (icollect [line (file:lines)]
                            line)))
  (base.on_new_file self filename))

(fn with-translated-line [reporter fn-name]
  (tset reporter fn-name (fn [self filename line-nr line ...]
                           ((. base fn-name) self filename line-nr (. self._file-lines line-nr) ...))))

(with-translated-line FnlReporter :on_hit_line)
(with-translated-line FnlReporter :on_mis_line)
(with-translated-line FnlReporter :on_empty_line)

(fn report []
  (dofile "fnlcov/io-patch.fnl")
  (luacov-reporter.report FnlReporter))

{: report
 : FnlReporter}
