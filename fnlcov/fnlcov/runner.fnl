(local runner (require :luacov.runner))
(require :fnlcov.reporter-patch)
(runner.run_report)
