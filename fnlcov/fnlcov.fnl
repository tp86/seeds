(local fennel (require :fennel))
(local correlating-searcher (fennel.make-searcher {:correlate true}))
;; This assumes that searcher installed by Fennel is the last one
;; There seems to be no good way to tell which searcher is installed by Fennel
(tset package.searchers
      (length package.searchers)
      correlating-searcher)
;; TODO: find first searcher installed by Fennel (based on debug.getinfo) and replace with correlating-searcher
;; patch for luacov reporter if runreport = true
(fennel.dofile "fnlcov/io-patch.fnl")
(require :luacov)
