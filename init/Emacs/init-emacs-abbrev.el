;;; init-emacs-abbrev.el --- abbrev mode init

;;; Commentary:


;;; Code:

;;; [ abbrev-mode ]

(require 'abbrev)

;;; setup my abbrevs file custom path.
(setq abbrev-file-name (expand-file-name "abbrev_defs" user-emacs-directory))
(setq save-abbrevs 'silently) ; save abbrevs when files are saved, nil: stop asking.
;; reads the abbreviations file on startup quietly.
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))

(define-abbrev-table 'global-abbrev-table
  '(("mynick" "stardiviner")
    ("myemail" "numbchild@gmail.com")
    ("mygmail" "numbchild@gmail.com")
    ("mygmailformat" "numbchild[@]{gmail}.com")
    ("myhomepage" "http://stardiviner.github.io")
    ("mytwitter" "@numbchild")
    ("myqq" "348284894")))

;;; define more keybindings [C-x a]
(define-key abbrev-map (kbd "/") 'exapnd-abbrev)
(define-key abbrev-map (kbd "e") 'edit-abbrevs)
(define-key abbrev-map (kbd "M-l") 'list-abbrevs)
(define-key abbrev-map (kbd "i") 'inverse-add-mode-abbrev)
(define-key abbrev-map (kbd "I") 'inverse-add-global-abbrev)

;; (add-hook 'org-mode-hook #'abbrev-mode)

;;; [ dabbrev ] -- Dynamic Abbrevs [M-/]

;; (require 'dabbrev)


(provide 'init-emacs-abbrev)

;;; init-emacs-abbrev.el ends here
