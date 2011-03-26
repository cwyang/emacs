(require 'slime-cl-pitfalls)
(add-to-list 'load-path "~/slime")
(require 'slime)

(add-to-list 'load-path "~/emacs/clojure/swank-clojure/")
(add-to-list 'load-path "~/emacs/clojure/clojure-mode")
(setq swank-clojure-binary "cloj")
(require 'clojure-auto)
(require 'swank-clojure-autoload)

(add-to-list 'slime-lisp-implementations '(sbcl ("/usr/local/bin/sbcl")))

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(setq auto-mode-alist
      (append '(("\\.cl$" . lisp-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.el$" . lisp-mode)) auto-mode-alist))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "/usr/local/bin/sbcl"
;      slime-lisp-implementations '((sbcl ("sbcl") :coding-system euc-kr-unix))
      lisp-indent-function 'common-lisp-indent-function
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-startup-animation nil)

;; below cut from http://paste.lisp.org/display/10269

(defmacro defslime-start (name lisp)
  `(defun ,name ()
     (interactive)
     (slime ,lisp)))

(defslime-start clisp "clisp")
(defslime-start sbcl "sbcl")
;(defslime-start clojure "clojure")
(defun clojure ()
	(interactive)
	(slime-start* (slime-lookup-lisp-implementation 
		slime-lisp-implementations (intern "clojure"))))

(defun mb:move-past-close ()
  "Move past next `)' and ensure just one space after it."
  (interactive)
  (delete-horizontal-space)
  (up-list))

(defun cw:my-backward-sexp ()
  "Move back sexp unless over ')' or '('"
  (interactive)
  (if (or (eq (char-before) ?\))
	  (eq (char-before) ?\())
      (backward-char)
      (backward-sexp)))

(defun cw:my-forward-sexp ()
  "Move back sexp unless over ')' or '('"
  (interactive)
  (if (or (eq (char-after) ?\))
	  (eq (char-after) ?\())
      (forward-char)
      (forward-sexp)))

(define-key slime-mode-map (kbd "(") 'insert-parentheses)
(define-key slime-mode-map (kbd ")") 'mb:move-past-close)
(define-key slime-mode-map (kbd "RET") 'newline-and-indent)
(define-key slime-mode-map (kbd "<return>") 'newline-and-indent)

(define-key slime-mode-map (kbd "C-b") 'backward-char)
(define-key slime-mode-map (kbd "C-M-b") 'cw:my-backward-sexp)
(define-key slime-mode-map (kbd "C-t") 'transpose-chars)
(define-key slime-mode-map (kbd "C-M-t") 'transpose-sexps)
(define-key slime-mode-map (kbd "C-f") 'forward-char)
(define-key slime-mode-map (kbd "C-M-f") 'cw:my-forward-sexp)
(define-key slime-mode-map (kbd "C-k") 'kill-line)
(define-key slime-mode-map (kbd "C-M-k") 'kill-sexp)

(defun mb:unwrap-next-sexp (&optional kill-n-sexps)
  "Convert (x ...) to ..."
  (interactive "P")
  (setf kill-n-sexps (if (null kill-n-sexps)
                         1
                         kill-n-sexps))
  (save-excursion
    (forward-sexp)
    (backward-delete-char 1)
    (backward-up-list)
    (delete-char 1)
    (unless (zerop kill-n-sexps)
      (kill-sexp kill-n-sexps)))
  (just-one-space))

(defun mb:center-next-sexp (&optional num-sexps)
  (interactive "P")
  (save-excursion
    (forward-sexp num-sexps)
    (let ((end-point (point)))
      (backward-sexp num-sexps)
      (let* ((start-point (point))
             (start-line (count-lines (point-min) (point)))
             (num-lines (count-lines start-point end-point)))
        (goto-line (+ start-line (/ num-lines 2)))
        (recenter)))))

(define-key slime-mode-map (kbd "C-'") 'mb:unwrap-next-sexp)
(define-key slime-mode-map (kbd "C-,") 'backward-up-list)
(define-key slime-mode-map (kbd "C-.") 'down-list)
(define-key slime-mode-map (kbd "C-M-l") 'mb:center-next-sexp)

(defun mb:complete-backslash ()
  (interactive)
  (if (eql last-command 'mb:complete-backslash)
      (progn
        (backward-delete-char 1)
        (slime-complete-symbol))
      (self-insert-command 1)))

(define-key slime-mode-map (kbd "\\") 'mb:complete-backslash)
(define-key slime-mode-map (kbd "C-c TAB") 'slime-complete-form)
(define-key global-map (kbd "<f1>") 'slime-selector)

(setf slime-save-buffers nil)

(require 'parenface)
(require 'paredit)
(define-key slime-mode-map (kbd "M-SPC") 'slime-complete-symbol)
(slime-setup '(slime-fancy))