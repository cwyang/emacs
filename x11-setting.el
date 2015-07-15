
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
      (create-fontset-from-fontset-spec
       "-*-fixed-medium-r-normal-*-16-*-*-*-*-*-fontset-clean16,
;       ascii:-schumacher-clean-*-r-normal-*-16-*,
       ascii:-*-terminus-medium-r-normal--16-*-*-*-*-*-iso8859-1,
       latin-iso8859-1:-sony-fixed-medium-r-normal-*-16-*-iso8859-1,
;       korean-ksc5601:-*-gulim-medium-r-normal-*-14-*-ksc5601*-*,
;NanumGothic,
;-xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1
       japanese-jisx0208:-jis-fixed-medium-r-normal--12-*-*-*-C-*-JISX0208.1983-0,
       korean-ksc5601:-sun-roundgothic-medium-r-normal-*-16-160-*-ksc5601*-*,
       chinese-gb2312:-*-medium-r-normal-*-16-*-gb2312*-*,
       chinese-cns11643-1:-*-medium-r-normal-*-16-*-cns11643*-1,
       chinese-cns11643-2:-*-medium-r-normal-*-16-*-cns11643*-2,
       chinese-cns11643-3:-*-medium-r-normal-*-16-*-cns11643*-3,
       chinese-cns11643-4:-*-medium-r-normal-*-16-*-cns11643*-4,
       chinese-cns11643-5:-*-medium-r-normal-*-16-*-cns11643*-5,
       chinese-cns11643-6:-*-medium-r-normal-*-16-*-cns11643*-6,
       chinese-cns11643-7:-*-medium-r-normal-*-16-*-cns11643*-7"
       '(medium))
    (set-default-font "Terminus 12")
;    (set-fontset-font "fontset-default" '(#x1100 . #xffdc) '("sun roundgothic" . "unicode-bmp"))
;    (set-fontset-font "fontset-default" '(#xe0bc . #xf66e) '("new gulim" . "unicode-bmp"))
    (setq default-frame-alist
	  (append '(
		    ;; Choose only one for your default font set.
		    (width . 80)
		    (height . 40)
					;		      (foreground-color . "#dcdccc")

		      (font . "fontset-clean16")
		    (cursor-color . "white")
		    (background-color . "#3f3f3f")
		    )
		  default-frame-alist))
    ))
