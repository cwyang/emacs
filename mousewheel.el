;;
;; mouse wheel support
;;
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)


(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

;; If you want to scroll by half a page instead of only 5 lines as above,
;; John Rowe sent this GNU Emacs code: 

(defun scroll-up-half ()
  "Scroll up half a page."
  (interactive)
  (scroll-up (/ (window-height) 2))
  )

(defun scroll-down-half ()
  "Scroll down half a page."
  (interactive)
  (scroll-down (/ (window-height) 2))
  )
(global-set-key [(mouse-5)] 'scroll-up-half)
(global-set-key [(mouse-4)] 'scroll-down-half)
