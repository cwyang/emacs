(use-package vterm
  :if (not (string-match-p "windows" (getenv "PATH")))
  :ensure t)
