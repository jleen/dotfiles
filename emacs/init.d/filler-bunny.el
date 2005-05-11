(map-char-table (lambda (char val)
                  (aset auto-fill-chars char t))
                auto-fill-chars)

(add-hook 'text-mode-hook (lambda () (refill-mode t)))

(add-hook 'text-mode-hook
          (lambda ()
            (set (make-local-variable 'default-text-properties)
                 (nconc default-text-properties '(face variable-pitch)))))
                                 