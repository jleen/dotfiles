;; PDFTeX support (mainly intended for Windows).
(defun jleen-pdftex-view ()
  "Preview the last `.pdf' file made by running PDFTeX under Emacs.
This means, made using \\[tex-region], \\[tex-buffer] or \\[tex-file].
The variable `tex-dvi-view-command' specifies the shell command for preview.
You must set that variable yourself before using this command,
because there is no standard value that would generally work."
  (interactive)
  (or tex-dvi-view-command
      (error "You must set `tex-dvi-view-command'"))
  (let ((tex-dvi-print-command tex-dvi-view-command))
    (jleen-pdftex-print)))

(defun jleen-pdftex-print (&optional alt)
  "Print the .pdf file made by \\[tex-region], \\[tex-buffer] or \\[tex-file].
Runs the shell command defined by `tex-dvi-print-command'.  If prefix argument
is provided, use the alternative command, `tex-alt-dvi-print-command'."
  (interactive "P")
  (let ((print-file-name-dvi (tex-append tex-print-file ".pdf"))
	test-name)
    (if (and (not (equal (current-buffer) tex-last-buffer-texed))
	     (buffer-file-name)
	     ;; Check that this buffer's printed file is up to date.
	     (file-newer-than-file-p
	      (setq test-name (tex-append (buffer-file-name) ".pdf"))
	      (buffer-file-name)))
	(setq print-file-name-dvi test-name))
    (if (not (file-exists-p print-file-name-dvi))
        (error "No appropriate `.pdf' file could be found")
      (if (tex-shell-running)
          (tex-kill-job)
        (tex-start-shell))
      (tex-send-command
       (if alt tex-alt-dvi-print-command tex-dvi-print-command)
       print-file-name-dvi t))))
