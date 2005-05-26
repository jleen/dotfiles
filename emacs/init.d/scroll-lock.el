;; Scroll madness
(defun scroll-up-one-line ()
  "Scrolls text of current window up one line."
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line ()
  "Scrolls text of current window down one line."
  (interactive)
  (scroll-down 1))
  
(defvar scroll-lock-mode-map
  (make-keymap)
  "Keymap for Scroll Lock mode.  Overrides the arrow keys to scroll
the window instead of moving the cursor.")

(define-key scroll-lock-mode-map [up] 'scroll-down-one-line)
(define-key scroll-lock-mode-map [down] 'scroll-up-one-line)

(define-minor-mode scroll-lock-mode
  "Minor mode in which up and down arrows scroll the window instead of
moving the cursor."
  nil
  " Scroll"
  scroll-lock-mode-map)

(easy-mmode-define-global-mode
 global-scroll-lock-mode scroll-lock-mode scroll-lock-mode)

(setq w32-scroll-lock-modifier nil)
(global-set-key [scroll] 'global-scroll-lock-mode)

(if running-xemacs
    (progn
      (global-set-key [(meta up)] 'scroll-down-one-line)
      (global-set-key [(meta down)] 'scroll-up-one-line))
  (global-set-key [?\033 up] 'scroll-down-one-line)
  (global-set-key [?\033 down] 'scroll-up-one-line)
  (global-set-key [M-up] 'scroll-down-one-line)
  (global-set-key [M-down] 'scroll-up-one-line))
