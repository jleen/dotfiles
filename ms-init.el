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

;; handy way to call sdv
(defun sdv (filename)
  (interactive "FRun sdv on file: ")
  (save-window-excursion
    (shell-command (concat "start sdv " filename " &" nil)))
  (message nil))
(define-key sd-prefix-map "\M-v" 'sdv)

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
(setq tags-file-name "e:\\office\\dev\\sts\\ETAGS")

;; build process
(setq compile-command "stsmake ")
                            
;; Here incipits an elaborate hack to support c.bat.

(load-library "shell")

;; First, the hook.
(add-hook 'shell-mode-hook 'jleen-shell-mode-hook)
(defun jleen-shell-mode-hook ()
  (setq comint-input-filter-functions (cons 'handle-c-bat
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
;; hit Enter a lot.  I don't get it.  The simplest workaround is to do
;; "start sdv" and "start windiff" instead of running them directly.


;;;; Coping With Widows, part ii

;; for C#
(load-library "compile")
(setq compilation-error-regexp-alist
      (cons '("\\(.:\\\\.*\\)(\\(.*\\),\\(.*\\)): \\(error\\|warning\\)"
              1 2 3)
            compilation-error-regexp-alist))
(load "csharp")


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

(setq c++-font-lock-extra-types
      (cons "V[a-z]\\w*" c++-font-lock-extra-types))
