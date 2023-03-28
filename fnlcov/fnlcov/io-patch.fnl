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

(λ LineStream.seek [self ?whence]
  (let [whence (or ?whence :cur)]
    (case whence
      :set (set self.position 1)
      :cur nil
      :end (set self.position (length self.lines))
      _ (error (string.format "wrong position specifier: %s" whence)))
    self.position))

(fn LineStream.close [self])

;; replace original io.open, so when it is called from luacov reporter, for Fennel files, it returns compiled version
(local original-io_open io.open)
(set io.open (fn [filename mode]
               (let [{:func caller} (debug.getinfo 2 :f)
                     run-file-func (. (require :luacov.reporter) :ReporterBase :_run_file)]
                 ;; TODO: better detection of Fennel sources (using fennel.path and package.searchpath)
                 (if (and (= caller run-file-func) (filename:match ".*%.fnl$"))
                   (with-open [file (original-io_open filename mode)]
                     (let [str (file:read :a)
                           (ok compiled) (pcall fennel.compile-string str {:correlate true :filename filename})]
                       (when (not ok)
                         (error (string.format "could not compile file '%s'" filename)))
                       (LineStream.new compiled)))
                   (original-io_open filename mode)))))
