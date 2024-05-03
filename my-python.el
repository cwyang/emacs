;; flycheck
(use-package python-pytest
  :ensure t)
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode t)
  ;; note that these bindings are optional
  (global-set-key (kbd "C-c n") 'flycheck-next-error)
  ;; this might override a default binding for running a python process,
  ;; see comments below this answer
  (global-set-key (kbd "C-c p") 'flycheck-previous-error)
  )
;; flycheck-pycheckers
;; Allows multiple syntax checkers to run in parallel on Python code
;; Ideal use-case: pyflakes for syntax combined with mypy for typing
(use-package flycheck-pycheckers
  :after flycheck
  :ensure t
  :init
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup)
    )
  (setq flycheck-pycheckers-checkers
    '(
      ;mypy3
      pyflakes
      ;pylint
      flake8
      )
    )
  )
;; elpy
(use-package elpy
  :after poetry
  :ensure t
  :config
  (elpy-enable)
  (add-hook 'elpy-mode-hook 'poetry-tracking-mode) ;; optional if you're using Poetry
  (setq elpy-rpc-virtualenv-path 'current)
  (setq elpy-syntax-check-command "~/.pyenv/shims/pyflakes") ;; or replace with the path to your pyflakes binary
  (setenv "PYTHONIOENCODING" "utf-8")
  (add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
  (add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
  (add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))
  ;; allows Elpy to see virtualenv
  (add-hook 'elpy-mode-hook
        ;; pyvenv-mode
        #'(lambda ()
           (pyvenv-mode +1)
           )
        )
  ;; use flycheck instead of flymake
  (when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
  )
;; poetry
(use-package poetry
  :ensure t)

;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))
;; (setq elpy-rpc-python-command "python3"
;;       python-indent-guess-indent-offset t
;;       python-indent-guess-indent-offset-verbose nil)

