(setq load-path
      (cons "/usr/lib/erlang/lib/tools-2.6.6.1/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(setq auto-mode-alist
      (append auto-mode-alist
	      '(("\\.[he]rl$"  . erlang-mode))))

(require 'erlang-start)