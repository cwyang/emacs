;;(add-to-list 'load-path "~/github/x/structured-haskell-mode/elisp")
;;(require 'shm)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;(add-hook 'haskell-mode-hook 'intero-mode)
;;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;;(remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(remove-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(defun haskell-send-eof ()
  "send eof to interactive buffer"
  (interactive)
  (process-send-eof (haskell-process-process (haskell-interactive-process))))
(add-hook 'haskell-interactive-mode-hook
          (lambda () (local-set-key (kbd "C-c C-d") 'haskell-send-eof)))

(defun haskell-822-workaround ()
    (setq haskell-process-args-ghci
          '("-ferror-spans" "-fshow-loaded-modules"))
    (setq haskell-process-args-cabal-repl
          '("--ghc-options=-ferror-spans --ghc-options -fshow-loaded-modules"))
    (setq haskell-process-args-stack-ghci
          '("--ghci-options=-ferror-spans -fshow-loaded-modules"
            "--no-build" "--no-load"))
    (setq haskell-process-args-cabal-new-repl
          '("--ghc-options=-ferror-spans -fshow-loaded-modules")))

(haskell-822-workaround)
