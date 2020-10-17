(use-package flycheck-rust
  :after flycheck
  :ensure t
  :init
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))
