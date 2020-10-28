;; parenthesis
(load "match-paren")
(global-set-key "%" 'match-paren)

(use-package paredit
  :ensure t
  :config
  (autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1))))

(use-package mic-paren
  :ensure t
  :config
  (paren-activate) ; activating
  (setq paren-priority 'close))

(show-paren-mode 1)
(setq show-paren-delay 0)
