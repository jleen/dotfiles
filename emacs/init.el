;;;; GNU Emacs Config File Worldwide
;;;; [tm] (C) Reg.Us.Pat.Off.
;;;; John M. Leen   jleen@world.std.com


;;;; Window System Settings

(cond ((not window-system)

       (when (>= emacs-major-version 21)

         ;; finally, tty colors!
         (when (color-defined-p "black")
           (set-face-inverse-video-p 'mode-line nil)
           (set-face-foreground 'mode-line "green")
           (set-face-background 'mode-line "blue")
           (set-face-attribute 'mode-line nil :weight 'bold))
             
         ;; xterm mouse support is a Good Thing
         (let ((termvar (getenv "TERM")))
           (and (or (string= termvar "xterm") (string= termvar "screen"))
                (xterm-mouse-mode 1))))
      
       ;; no stupid non-functional menu bar in text mode!
       (menu-bar-mode 0))
      
      (t
      
       ;; pretty colors
       (set-face-background 'default "snow1")
       (set-face-foreground 'region "black")
       (set-face-background 'region "light steel blue")
       (set-face-foreground 'modeline "white")
       (set-face-background 'modeline "navy")
       (set-face-background 'highlight "cornflower blue")
       (setq default-frame-alist
             (append default-frame-alist
                     '((cursor-color . "dodgerblue3"))))

       (when (>= emacs-major-version 21)

         ;; prettier colors
         (set-face-background 'menu "snow2")
         (set-face-background 'tool-bar "snow2")
         (set-face-background 'scroll-bar "snow2")
         (set-face-foreground 'mode-line "black")
         (set-face-background 'mode-line (if (string= window-system "w32")
                                             "#D4D0C8" "seashell3"))
         (set-face-background 'cursor "dodgerblue3")
         (set-face-background 'isearch "steelblue3")
         (set-face-foreground 'isearch "black")
         (set-face-background 'isearch-lazy-highlight-face "azure3")

         ;; mouse wheel support in X
         (mouse-wheel-mode 1)

         ;; blink-cursor-mode is the new menu-bar-mode
         (blink-cursor-mode 0)
         )))


;; inoffensive title bar
(setq frame-title-format '("%b - GNU Emacs " emacs-version " on " system-name))

;; useful faces
(when (or (>= emacs-major-version 21) window-system)
  (make-face 'brightblue)
  (set-face-foreground 'brightblue "blue")
  (make-face-bold 'brightblue))

;;;; Global Settings

;; fix the help character, needed on some stqqpid systems
(global-set-key "\^H" 'help-command)

;; every now and then I have to admit XEmacs has it right
(global-set-key "\M-g" 'goto-line)

;; clutter up the modeline
; (display-time) ; not today, thanks
(line-number-mode t)

;; If we visit a symlink, use that name; but give us the same
;; buffer if we later visit the file by a different name
;; (would *anyone* want different behavior than this?)
(setq find-file-visit-truename nil
      find-file-existing-other-name t)

;; make the EOF impenetrable
(setq next-line-add-newlines nil)

;; electric buffer list is your friend
(global-set-key "\^X\^B" 'electric-buffer-list)

;; fix some keypad anomalies:
;; by default, emacs defines delchar and ins,
;; but not inschar or del... go figure.
(global-set-key [delete] 'delete-char)
(global-set-key [insertchar] 'overwrite-mode)

;; make Linux Alt+PgUp/PgDn act like Sun Meta+Prior/Next
(global-set-key [?\033 prior] 'scroll-other-window-down)
(global-set-key [?\033 next] 'scroll-other-window)

;; define meta-arrow keys
(global-set-key [?\033 right] "\M-f")
(global-set-key [?\033 left] "\M-b")
(global-set-key [?\033 up] 'scroll-down-one-line)
(global-set-key [?\033 down] 'scroll-up-one-line)
(global-set-key [M-up] 'scroll-down-one-line)
(global-set-key [M-down] 'scroll-up-one-line)

;; and fix the X bindings too
(if (equal window-system 'x)
    (progn (define-key function-key-map [delete] [deletechar])
;; define Sun console keys (just for fun)
           (global-set-key [f11] 'keyboard-quit)
           (global-set-key [f12] 'repeat)
           (global-set-key [f14] 'undo)
           (global-set-key [f17] 'find-file)
           (global-set-key [f19] 'isearch-forward)))

;; and, at risk of offending Unix folks, let's make the keypad functions
;; more Windows-like
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; I never use a real vt320 so let's map [find] and [select] to
;; [home] and [end] since those are the physical keys I'm pressing
(if (equal (getenv "TERM") "vt320")
    (progn (global-set-key [find] [home])
           (global-set-key [select] [end])))
  
;; we're out of first grade; give us the dangerous stuff
(put 'eval-expression 'disabled nil)

;; only works in version 21, but harmless elsewhere
(setq backup-directory-alist '((".*" . "~/.emacs.d/backups")))

;; can't see any reason not to have this
(setq tags-revert-without-query t)


;;;; Mode-Specific Settings

;; mode determination
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.emacs" . emacs-lisp-mode)
                ("\\mutt" . text-mode)
                ("\\.article" . text-mode)
                ("\\.followup" . text-mode)
                ("\\.asps\\'" . html-mode)
                ("\\.aspx\\'" . html-mode)
                ("\\.hts\\'" . html-mode)
                ("\\.jss\\'" . java-mode)
                ("\\.resx\\'" . sgml-mode))))
(setq interpreter-mode-alist
      (append interpreter-mode-alist
              ''("scsh" . scheme-mode)))

;; less annoying comint behavior
(setq comint-scroll-show-maximum-output t)

;; make things friendlier, more colorful, and less tabular
(setq font-lock-use-colors t)
(add-hook 'mail-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'html-mode-hook 'turn-off-auto-fill)
(add-hook 'sgml-mode-hook 'turn-off-auto-fill)
(setq-default indent-tabs-mode nil)

;; make tabs stand out like a sore cursor
(setq-default x-stretch-cursor t)

;; file-type indicators for dired mode
(setq dired-listing-switches "-laF")
(setq dired-ls-F-marks-symlinks nil)

;; mailing and mailboxes
(add-hook 'mail-mode-hook 'mail-abbrevs-setup)
(add-hook 'mail-mode-hook
          (lambda ()
            (substitute-key-definition
             'next-line 'mail-abbrev-next-line
             mail-mode-map global-map)
            (substitute-key-definition
             'end-of-buffer 'mail-abbrev-end-of-buffer
             mail-mode-map global-map)))
(load "~/.mailabbrevs" t)
(setq mail-archive-file-name "~/mail/sent"
;; the below is superfluous with vm
;      mail-default-headers (concat "X-Mailer: GNU Emacs "
;                                  emacs-version "\n")
      mail-yank-prefix "> "
      mail-from-style 'angles)

;; let's play with vm
(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)
(substitute-key-definition 'compose-mail 'vm-mail global-map)

;; options for CC mode and its variants
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-toggle-hungry-state 1)
            (define-key c-mode-base-map "\C-m" 'newline-and-indent)
            (define-key c-mode-base-map "\C-?" 'jleen-electric-delete)))
(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'case-label '+)))


;;;; Some of My Own Evil Creations

(defun rmail-really-quit ()
  "Quit out of RMAIL.
Hook `rmail-quit-hook' is run after expunging.

This is jleen's version which kills the RMAIL buffer to avoid
annoying problems with simultaneous Emacs sessions."
  (interactive)
  (rmail-expunge-and-save)
  (when (boundp 'rmail-quit-hook)
    (run-hooks 'rmail-quit-hook))
  ;; Don't switch to the summary buffer even if it was recently visible.
  (when rmail-summary-buffer
    (replace-buffer-in-windows rmail-summary-buffer)
    (kill-buffer rmail-summary-buffer))
  (let ((obuf (current-buffer)))
    (quit-window)
    (replace-buffer-in-windows obuf)
    (kill-buffer obuf)))

(defun advance-past-mail-headers ()
  "Position the cursor at the beginning of the body of an email message,
underneath the headers.  Meant to be used when entering a mutt/elm/pine
temp file."
  (beginning-of-buffer)
  (let ((beg (point)))
    (search-forward-regexp "^$")
    (facemenu-set-face 'brightblue beg (point))
    (forward-line)
    (not-modified)
    (message nil)))

;; The whole point of advance-past-mail-headers is to run it
;; automatically.
(add-hook 'text-mode-hook
          (lambda ()
            (and buffer-file-name
                 (string-match "\\(/tmp/mutt-\\|\\.article\\|\\.followup\\)"
                               buffer-file-name)
                 (advance-past-mail-headers))))

(defun scroll-up-one-line ()
  "Scrolls text of current window up one line."
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line ()
  "Scrolls text of current window down one line."
  (interactive)
  (scroll-down 1))
  
(defun jleen-electric-delete (arg)
  "Deletes preceding character or whitespace, excluding newlines.
If `c-hungry-delete-key' is non-nil, as evidenced by the \"/h\" or
\"/ah\" string on the mode line, then all preceding whitespace is
consumed.  If however an ARG is supplied, or `c-hungry-delete-key' is
nil, or point is inside a literal then the function in the variable
`c-delete-function' is called. 

`jleen-electric-delete', unlike the usual `c-elecric-delete', stops after
gobbling a single newline, after which it will automatically indent the
line we've landed on.

This sounds weird, but it feels right to me."
  (interactive "*P")
  (if (or (not c-hungry-delete-key)
          arg
          (c-in-literal))
      (funcall c-backspace-function (prefix-numeric-value arg))
    (let ((here (point)))
      (skip-chars-backward " \t")
      (skip-chars-backward "\n" (- (point) 1))
      (if (= (point) here)
          (funcall c-backspace-function 1)
        (delete-region (point) here)
        (c-indent-command)))))


;;;; Get Local Settings

;; Load a site-specific .emacs if it exists.
;; We do this last so we can override the stuff above.
(load "~/.site-emacs" t)

;; cvs wuz here