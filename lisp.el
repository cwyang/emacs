(add-hook 'lisp-mode-hook
	  (lambda ()
	    (outline-minor-mode)
	    (make-local-variable 'outline-regexp)
	    (setq outline-regexp "^(.*")
	    (set (make-local-variable lisp-indent-function)
		 'common-lisp-indent-function)))