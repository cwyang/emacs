(defun my-rust-mode-hook ()
  (flycheck-rust-setup)
  (setq indent-tabs-mode nil)
)

(use-package flycheck-rust
  :after flycheck
  :ensure t
  :init
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook 'my-rust-mode-hook)))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; rustup toolchain add nightly
;; rustup component add rust-src
;; cargo +nightly install racer
