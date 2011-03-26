
;;; =============================================================
;;; Fonts and Frame for Unix X11
;;; =============================================================

(if (eq window-system 'x)
    (progn
      ;; For clean Ascii and its bold font.
      ;;  No need to install additional fonts.
      ;;  But, this does not show ISO-8859-1 character sets.
      ;;  Seems to be a bug of Emacs 20.2 where ISO-8859-1 charset font
      ;;  setting is overriden by ASCII charset font setting
      ;;  Bold font is shown as plain font.
;      (setq initial-frame-alist '((width . 40)
;				  (height . 40)))
    (set-default-font "Terminus 10")
    (set-fontset-font "fontset-default" 
	'(#x1100 . #xffdc) '("sun roundgothic" . "unicode-bmp"))
    (set-fontset-font "fontset-default" 
	'(#xe0bc . #xf66e) '("new gulim" . "unicode-bmp"))
      (setq default-frame-alist
	    (append '(
		      ;; Choose only one for your default font set.
		      (width . 80)
		      (height . 40)
;		      (foreground-color . "#dcdccc")
		      (cursor-color . "white")
		      (background-color . "#3f3f3f")
		      )
		    default-frame-alist))
      ))
