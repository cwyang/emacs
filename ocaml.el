; ocaml
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
      (add-hook 'caml-mode-hook 'merlin-mode t)))
(add-to-list 'load-path "/home/cwyang/.opam/4.06.0/share/emacs/site-lisp")
(require 'ocp-indent)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'merlin-company-backend))
(add-hook 'merlin-mode-hook 'company-mode)
