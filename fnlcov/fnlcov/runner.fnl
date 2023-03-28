;; execute luacov runner from Fennel, so it is aware of fennel sources
(local runner (require :luacov.runner))
(runner.run_report)
