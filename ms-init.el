;;;; GNU Emacs Config File Microsoft
;;;; [tm] (C) Reg.Us.Pat.Off.
;;;; John M. Leen   jleen@microsoft.com


;;;; House Rules

;; start out in the right place
(cd "E:\\office\\dev\\sts")

;; and keep looking in the right place
(setq load-path (append '("e:/local/elisp") load-path))
(setq completion-ignored-extensions
      (remove ".log" completion-ignored-extensions))

;; Source Depot support roooooooocks
(load-library "sd")
(sd-set-sd-executable "e:/office/dev/otools/bin/x86/sd.exe")
(setenv "SDCONFIG" "sd.ini")
(setq sd-use-sdconfig-exclusively t)
(global-auto-revert-mode 1)   ;; make syncing less traumatic

;; coding style
(defun jleen-ms-house-style-c-mode-hook ()
  (setq c-basic-offset 4
        indent-tabs-mode nil
        tab-width 4
        c-label-minimum-indentation 0
        )
  (c-set-style "stroustrup")
  )
(add-hook 'c-mode-common-hook 'jleen-ms-house-style-c-mode-hook)
(add-hook 'java-mode-hook 'jleen-ms-house-style-c-mode-hook)
(defun jleen-ms-house-style-sql-mode-hook ()
  (define-key sql-mode-map [tab] 'indent-relative))
(add-hook 'sql-mode-hook 'jleen-ms-house-style-sql-mode-hook)

;; tags
(setq tags-file-name "e:\\office\\dev\\sts\\TAGS")

;; build process
(setq compile-command "stsmake ")
                            
;; Here incipits an elaborate hack to support c.bat.

(load-library "shell")

;; First, the hook.
(add-hook 'shell-mode-hook 'jleen-shell-mode-hook)
(defun jleen-shell-mode-hook ()
  (setq comint-completion-suffix (cons "\\" " ")
        shell-dirstack-query "cd"
        comint-input-filter-functions (cons 'handle-c-bat
                                            comint-input-filter-functions)
        comint-preoutput-filter-functions
        (cons 'handle-c-bat-output
              comint-preoutput-filter-functions)
        )
  (set (make-local-variable 'c-bat-just-run) nil)
  )

;; Next, the input filter.
(defun handle-c-bat (str)
  (when (string-match "^c " str)
    (setq c-bat-just-run t)))

;; Finally, the output filter.
(defun handle-c-bat-output (str)
  (if c-bat-just-run
      (progn (setq c-bat-just-run nil)
             (shell-resync-dirs)
             "") ;; make the whole "c" command invisible
    str))

;; And that does it.

;; The other thing you're going to want to do is create a file with
;; the unfortunate name .emacs_cmdproxy.exe with the contents:
;;      cmd /q /k e:\office\dev\otools\bin\oenvtest.bat && exit
;;                ^^^^^^^^^^^^^ (or whatever)
;; which seems to be the best way to get your Office environment when
;; you bring up an emacs shell.
;;
;; Alternately, you can just start emacs from an Office.NET dev shell.
;;
;; Either way, you'll encounter weird problems with certain utilities,
;; most notably sdv and windiff.  They'll seem not to run until you
;; hit Enter a lot.  I don't get it.  I have a workaround in the form
;; of sdv.cmd and windiff.cmd in my Utils directory.


;;;; Coping With Widows

;; new furniture
(setq grep-command "findstr /sn ")
(setq explicit-cmdproxy.exe-args '("/q"))

;; I know this is "deprecated", but how else am I going to make things
;; work?  I suppose I'm hurting RMS's feelings, but I work at
;; Microsoft, for crying out loud.  Sorry, RMS.
(setq directory-sep-char ?\\)

;; for C#
(load-library "compile")
(setq compilation-error-regexp-alist
      (cons '("\\(.:\\\\.*\\)(\\(.*\\),\\(.*\\)): \\(error\\|warning\\)"
              1 2 3)
            compilation-error-regexp-alist))
(defun csharp-mode ()
  "Major mode for editing C# source files.  (Okay, I confess.  It just
kicks you into Java mode, and hacks the keyword list to handle \"get\"
and \"set\".)"
  (interactive)
  (java-mode)
  (setq c-conditional-key "\\<\\(for\\|if\\|do\\|else\\|while\\|switch\\|try\\|catch\\|finally\\|synchronized\\|get\\|set\\)\\>[^_]"
        mode-name "CSharp")
  (font-lock-add-keywords nil '(("\\<\\(get\\|set\\)\\>" . font-lock-keyword-face))))
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.cs" . csharp-mode))))

;; fix for emacs's innate aversion to spaces
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


;;;; Flavor of the Month

;; look
(set-default-font
 "-outline-Lucida Console-normal-r-normal-normal-12-*-96-96-c-*-iso8859-2")
(global-font-lock-mode 1)
(setq default-frame-alist
      (append default-frame-alist
              '((height . 60) (top . 25) (left . (- 20)))))

;; feel
(global-set-key [f7] (lambda ()
                       (interactive)
                       (find-file "e:\\office\\Logs")))
(global-set-key [M-f7] (lambda ()
                         (interactive)
                         (find-file-other-window "e:\\office\\Logs")))
