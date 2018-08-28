;;
;; KOREAN LANGUAGE SETTING
;;
(require 'cl)
(when enable-multibyte-characters
  (set-language-environment "Korean")

  ;(setq-default file-name-coding-system 'euc-kr)
  ;; the following setting is unnecessary from 20.5 >
  (when (string-match "^3" (or (getenv "HANGUL_KEYBOARD_TYPE") ""))
    (setq default-korean-keyboard "3f"))
  (setq input-method-verbose-flag nil
        input-method-highlight-flag nil)
  ;(prefer-coding-system 'euc-kr)
  ;(set-default-coding-systems 'euc-kr)
  ;;(setq default-process-coding-system '(euc-kr . euc-kr))
  (if window-system
      (global-set-key "\C-\\" 'undefined)
      (global-set-key "\C-\\" 'toggle-korean-input-method ))
  (add-hook 'quail-inactivate-hook 'delete-quail-completions)
  (defun delete-quail-completions ()
    (when (get-buffer "*Quail Completions*")
      (kill-buffer "*Quail Completions*")))

  ;; emacs 21 or later, xim is usable
;  (set-keyboard-coding-system 'euc-kr)
  (when (assq 'encoded-kbd-mode minor-mode-alist)
    (setf (second (assq 'encoded-kbd-mode minor-mode-alist)) ""))

  (unless window-system
    ;(set-terminal-coding-system 'euc-kr)
    (when (boundp 'encoded-kbd-mode-map)
      (define-key encoded-kbd-mode-map [27] nil)))

  ;; in case default doesn't work
  ;;(set-selection-coding-system 'ctext)

  ;; Hangul Mail setting
  ;(setq-default sendmail-coding-system 'euc-kr)

  ;; turn off C-h during input -- this code should be invoked after
  ;; loading quail but before loading specific keymap
  (require 'quail)
  (loop for kpair in '(("C-h" . quail-delete-last-char)
                       ("C-?" . quail-delete-last-char)
                       ("C-SPC" . set-mark-command)
                       ("<f1>" . quail-translation-help))
     do (define-key quail-translation-keymap
	    (read-kbd-macro (car kpair)) (cdr kpair))
     do (define-key quail-conversion-keymap
	    (read-kbd-macro (car kpair)) (cdr kpair)))
  (define-key global-map (kbd "C-x RET s") 'decode-coding-region)
  (define-key global-map (kbd "C-@") 'toggle-korean-input-method)

  ;; hangul <-> english auto conversion
  ;;(when window-system (require 'hangul-auto))
  )
