(load "~/emacs/xterm-frobs")
(load "~/emacs/xterm-title")
(setq hostname (let ((hostname (downcase (system-name))))
		 (save-match-data
		   (substring hostname (string-match "^[^.]+" hostname) (match-end 0)))))

;; To use this, put something like the following in your .emacs:
(when (and (not window-system)
	   (string-match "^xterm" (getenv "TERM")))
  (require 'xterm-title)
  (xterm-title-mode 1))

(defun my-format-mode-line (dummy &rest dummy2)
  (let ((foo (replace-regexp-in-string "/home/cwyang" "~" buffer-file-name)))
    (concat
     (if buffer-read-only " % "
       t (if (buffer-modified-p) " * "))
     (concat "Emacs@" hostname ": ")
					;	    (buffer-name)
     foo
     )))

