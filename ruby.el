(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)))

(setq ri-ruby-script "/home/cwyang/emacs/ri-emacs.rb")
(autoload 'ri "/home/cwyang/emacs/ri-ruby.el" nil t)
(add-hook 'ruby-mode-hook (lambda () (local-set-key 'f1 'ri)))