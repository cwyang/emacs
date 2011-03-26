(defun noninteractive-linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (c-set-style "K&R")
  (setq c-basic-offset 8)

  (c-toggle-auto-hungry-state 1)
  (setq tab-width 8)
  (setq c-indent-level 8)
  (setq c-brace-imaginary-offset 0)
  (setq c-brace-offset -8)
  (setq c-argdecl-indent 8)
  (setq c-label-offset -8)
  (setq c-continued-statement-offset 8)
  (setq indent-tabs-mode nil)
)

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (noninteractive-linux-c-mode))

(add-hook 'c-mode-hook (lambda ()
                         (noninteractive-linux-c-mode)))

(setq auto-mode-alist 
      (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode) 
	    auto-mode-alist))
