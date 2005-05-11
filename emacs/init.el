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
(setq frame-title-format '("%b - GNU Emacs " emacs-version " on "
                           (:eval (or (getenv "BOXNAME")
                                      system-name))))

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

;; can't say I'm a fan of horizontal scrolling
(setq truncate-partial-width-windows nil)

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
  
;; useful tag shortcuts
(global-set-key [?\C-.] (lambda () (interactive) (find-tag nil t)))
(global-set-key [?\C-,] (lambda () (interactive) (find-tag nil '-)))

;; some shortcuts for dev stuff
(global-set-key [f4] 'compile)
(global-set-key [f5] 'shell)
(global-set-key [M-f5] (lambda () (interactive)
                         (switch-to-buffer-other-window "*shell*")
                         (shell)))
(global-set-key [f6] 'grep)
(global-set-key [M-f6] (lambda () (interactive)
                         (switch-to-buffer-other-window "*grep*")))

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


;;;; Coping With Windows

(when (eq window-system 'w32)
  
  ;; new furniture
  (setq grep-command "findstr /sn ")
  (setq explicit-cmdproxy.exe-args '("/q"))

  ;; I know this is "deprecated", but how else am I going to make things
  ;; work?  I suppose I'm hurting RMS's feelings, but I work at
  ;; Microsoft, for crying out loud.  Sorry, RMS.
  (setq directory-sep-char ?\\)

  ;; directory sync for M-x shell
  (add-hook 'shell-mode-hook 'jleen-win-shell-settings)
  (defun jleen-win-shell-settings ()
    (setq comint-completion-addsuffix (cons "\\" " ")
          shell-dirstack-query "cd"))

  (setq latex-run-command "pdftex.exe -progname=pdflatex")

  (add-hook 'latex-mode-hook
            (lambda ()
              (define-key latex-mode-map "\C-c\C-v" 'jleen-pdftex-view)))
  )


;;;; Some of My Own Evil Creations

(defun webster ()
  "Look up the word at point in webster."
  (interactive)
  (compile-internal
   (concat "webster " (current-word))
   "No errors."
   "webster"))

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

;; fix for emacs's innate aversion to spaces
(defun jleen-fix-dirs-spaces ()
  (defun shell-resync-dirs ()
    "**hacked by jleen to support spaces in filenames**
Resync the buffer's idea of the current directory stack.
This command queries the shell with the command bound to
`shell-dirstack-query' (default \"dirs\"), reads the next
line output and parses it to form the new directory stack.
DON'T issue this command unless the buffer is at a shell prompt.
Also, note that if some other subprocess decides to do output
immediately after the query, its output will be taken as the
new directory stack -- you lose. If this happens, just do the
command again."
    (interactive)
    (let* ((proc (get-buffer-process (current-buffer)))
           (pmark (process-mark proc)))
      (goto-char pmark)
      (insert shell-dirstack-query) (insert "\n")
      (sit-for 0) ; force redisplay
      (comint-send-string proc shell-dirstack-query)
      (comint-send-string proc "\n")
      (set-marker pmark (point))
      (let ((pt (point))) ; wait for 1 line
        ;; This extra newline prevents the user's pending input from spoofing us.
        (insert "\n") (backward-char 1)
        (while (not (looking-at ".+\n"))
          (accept-process-output proc)
          (goto-char pt)))
      (goto-char pmark) (delete-char 1) ; remove the extra newline
      ;; That's the dirlist. grab it & parse it.
      (let* ((dl (buffer-substring (match-beginning 0) (1- (match-end 0))))
             (dl-len (length dl))
             (ds '())                     ; new dir stack
             (i 0))
        (while (< i dl-len)
          ;; regexp = optional whitespace, (non-whitespace), optional whitespace
          ;; jleen hacked next line
          (string-match "\\(.*\\)" dl i) ; pick off next dir
          (setq ds (cons (concat comint-file-name-prefix
                                 (substring dl (match-beginning 1)
                                            (match-end 1)))
                         ds))
          (setq i (match-end 0)))
        (let ((ds (nreverse ds)))
          (condition-case nil
              (progn (shell-cd (car ds))
                     (setq shell-dirstack (cdr ds)
                           shell-last-dir (car shell-dirstack))
                     (shell-dirstack-message))
            (error (message "Couldn't cd")))))))
  )
(add-hook 'shell-mode-hook 'jleen-fix-dirs-spaces)

(global-font-lock-mode)

(let ((init-dir (concat (getenv "CONFIGDIR") "/emacs/init.d/")))
  (mapcar (lambda (filename)
            (unless (string= (substring filename 0 1) ".")
              (load (concat init-dir filename))))
          (directory-files (concat (getenv "CONFIGDIR") "/emacs/init.d")
                           (not 'full) ".*\\.el")))
