(setq load-path
      (cons erlang-emacs-dir load-path))
(setq exec-path (cons 
		 (concat erlang-root-dir "bin")
		 exec-path))
(setq auto-mode-alist
      (append auto-mode-alist
	      '(("\\.[he]rl$"  . erlang-mode))))

(require 'erlang-start)