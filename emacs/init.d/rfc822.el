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
