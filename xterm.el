(load "~/emacs/xterm-frobs")
(when (and (not window-system)
	   (string-match "^xterm" (getenv "TERM")))
  (require 'xterm-title)
  (xterm-title-mode 1))

(setq hostname (let ((hostname (downcase (system-name))))
		 (save-match-data
		   (substring hostname (string-match "^[^.]+" hostname) (match-end 0)))))

;; To use this, put something like the following in your .emacs:

(defun my-format-mode-line (dummy &rest dummy2)
  (let ((foo (if (null buffer-file-name) 
		 ""
	       (replace-regexp-in-string "/home/cwyang" "~" buffer-file-name))))
    (concat
     (if buffer-read-only " % "
       t (if (buffer-modified-p) " * "))
     (concat "Emacs@" hostname ": ")
					;	    (buffer-name)
     foo)))

