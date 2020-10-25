;; parenthesis
(load "match-paren")

(load "paredit") 
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))

(paren-activate) ; activating
(setf paren-priority 'close)
;(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
;  (require 'mic-paren) ; loading
;  (paren-activate) ; activating
;  (setf paren-priority 'close))

(global-set-key "%" 'match-paren)
