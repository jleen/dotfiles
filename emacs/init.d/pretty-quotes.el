(defun insert-pretty-quote (left-quote right-quote straight-quote)
  (insert (cond ((inside-tag) straight-quote)
                ((at-word-start) left-quote)
                (t right-quote))))

(defun inside-tag ()
  (save-excursion
    (search-backward-regexp "<\\|>\\|^")
    (eq (char-after (point)) ?<)))
    

(defun at-word-start ()
  (or (= (current-column) 0)
      (memq (char-before (point)) '(?  ?\t ?- ?\; ?())))

(defun insert-pretty-single-quote ()
  (interactive)
  (insert-pretty-quote "&lsquo;" "&rsquo;" ?\'))

(defun insert-pretty-double-quote ()
  (interactive)
  (insert-pretty-quote "&ldquo;" "&rdquo;" ?\"))

(defun insert-tex-single-quote ()
  (interactive)
  (insert-pretty-quote "`" "'" ?\'))

(defun insert-tex-double-quote ()
  (interactive)
  (insert-pretty-quote "``" "''" ?\"))

(defun maybe-replace-em-dash ()
  (interactive)
  (if (eq (char-before (point)) ?-)
      (progn (backward-delete-char 1)
             (insert "&mdash;"))
    (insert ?-)))

(defun maybe-replace-ellipsis ()
  (interactive)
  (if (and (eq (char-before (point)) ?.)
           (eq (char-before (- (point) 1)) ?.))
      (progn (backward-delete-char 2)
             (insert "&hellip;"))
    (insert ?.)))

(defun bind-pretty-html-quotes ()
  (define-key html-mode-map "'" 'insert-pretty-single-quote)
  (define-key html-mode-map "\"" 'insert-pretty-double-quote)
  (define-key html-mode-map "-" 'maybe-replace-em-dash)
  (define-key html-mode-map "." 'maybe-replace-ellipsis))

;(add-hook 'html-mode-hook 'bind-pretty-html-quotes)

(defun bind-texlike-quotes ()
  (define-key html-mode-map "'" 'insert-tex-single-quote)
  (define-key html-mode-map "\"" 'insert-tex-double-quote))
  