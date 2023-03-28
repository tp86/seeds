(local fennel (require :fennel))

(local LineStream {})
(set LineStream.__index LineStream)
(fn LineStream.new [str]
  (let [lines (icollect [line (str:gmatch "[^\n]*")]
                line)]
    (setmetatable {: lines
                   :position 1}
                  LineStream)))
(fn LineStream.read [self ?format]
  (let [format (-> (or ?format :l)
                   (: :match "%w"))
        pos self.position]
    (case format
      :l (let [line (. self.lines pos)]
           (set self.position (+ pos 1))
           line)
      :a (let [last (length self.lines)
               lines (icollect [i line (ipairs self.lines)]
                       (if (<= pos i) line))]
           (set self.position (+ last 1))
           (table.concat lines "\n"))
      _ (error (string.format "format '%s' not implemented" format)))))
(fn LineStream.seek [self ?whence]
  (let [whence (or ?whence :cur)]
    (case whence
      :set (set self.position 1)
      :cur nil
      :end (set self.position (length self.lines))
      _ (error (string.format "wrong position specifier: %s" whence)))
    self.position))
(fn LineStream.close [self])

;; additionally, create custom Reporter overriding on_mis_line, on_hit_line and on_empty_line to get fennel src line, not compiled
(local original-io_open io.open)
(set io.open (fn [filename mode]
               (let [{:func caller} (debug.getinfo 2 :f)
                     run-file-func (. (require :luacov.reporter) :ReporterBase :_run_file)]
                 (if (= caller run-file-func)
                   (let [(file err) (original-io_open filename mode)]
                     (when (not file)
                       (values file err))
                     (let [str (file:read :a)
                           (ok compiled) (pcall fennel.compile-string str {:correlate true :filename filename})]
                       (when (not ok)
                         (error (string.format "could not compile file '%s'" filename)))
                       (LineStream.new compiled)))
                   (original-io_open filename mode)))))
