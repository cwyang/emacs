; from kevsmith@github's hl-emacs
(provide 'autosave_config)

;; Put autosave files (ie #foo#) in one place
(defvar autosave-dir "~/tmp/emacs_autosaves")

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

;; put backup files (ie foo~) in one place too
;; The backup-directory-alist list contains regexp->dir mapping
;; filenames matching a regexp are backed up in the corresponding
;; directory. Emacs will mkdir it if necessary
(defvar backup-dir "~/tmp/emacs_backups/")
(setq backup-directory-alist (list (cons ".*" backup-dir)))