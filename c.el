(defun noninteractive-linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (c-set-style "K&R")
  (setq c-basic-offset 4)

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

(defun c4-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (c-set-style "K&R")
  (setq c-basic-offset 4)

  (c-toggle-auto-hungry-state 1)
  (setq tab-width 4)
  (setq c-indent-level 4)
  (setq c-brace-imaginary-offset 0)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 4)
  (setq c-label-offset -4)
  (setq c-continued-statement-offset 4)
  (setq indent-tabs-mode nil)
)

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
;  (noninteractive-linux-c-mode)
  (c4-mode))

(add-hook 'c-mode-hook (lambda ()
                         (noninteractive-linux-c-mode)))

(setq auto-mode-alist 
      (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode) 
	    auto-mode-alist))

;; style I want to use in c++ mode
(c-add-style "my-style"
             '("stroustrup"
               (indent-tabs-mode . nil)        ; use spaces rather than tabs
               (c-basic-offset . 4)            ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                                   (brace-list-open . 0)
                                   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
