;;; init-my-prog-lang-database.el --- init Databases settings

;;; Commentary:



;;; Code:

;;; [ sql-indent]
;; (require 'sql-indent)



;;; Auto Uppercase SQL Keywords
;; (unless (not (featurep 'sqlup-mode))
;;   (setq sql-abbrev-file-name "~/.emacs.d/init/abbrevs/sql.abbrev")
;;   (if (file-exists-p sql-abbrev-file-name)
;;       (load sql-abbrev-file-name)))


;;; [ sqlup-mode ]

;;; Usage:
;; - The capitalization is triggered when you press 'SPC', ';', ',', or '(', '\r' (Enter),
;; - [C-c u] region :: `sqlup-capitalize-keywords-in-region'

(add-hook 'sql-mode-hook 'sqlup-mode)
(add-hook 'sql-inretactive-mode-hook 'sqlup-mode)

;; (add-hook 'sqlup-mode-hook
;;           (lambda ()
;;             (setq sqlup-keywords
;;                   (append sqlup-keywords
;;                           '("text" "glob" "offset")))))


;;; [ sqled-mode ]


;;; [ edbi ]

;;; Usage:
;;
;; - M-x `edbi:open-db-viewer' opens a dialog for DB connection.
;;
;; Check the key-bind `edbi:dbview-keymap'.
;;
;;     j,k, n,p : navigation for rows
;;     c : switch to query editor buffer
;;     RET : show table data
;;     SPC : show table definition
;;     q : quit and disconnect

;; install Perl packages:
;; $ cpan RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql

(require 'edbi)

(define-key my-prog-database-map (kbd "d") 'edbi:open-db-viewer)


;;; [ edbi-sqlite ] -- edbi helper application

;;; Usage:
;;
;; Run `edbi-sqlite' interactive command. Select appropriate sqlite database
;; file. Type `RET' and you'll be connected to specified database with edbi
;; tool.

(require 'edbi-sqlite)


;;; [ edbi-database-url ] -- run edbi with database url.

;;; Usage:
;;
;; Specify database url with environment variable
;;
;;   M-x setenv RET DATABASE_URL RET pgsql://me:secret@localhost:5678/test
;;
;; Connect to you database
;;
;;   M-x edbi-database-url
;;
;; Optionally you can specify database url by marking region or type it
;; interactively.

(require 'edbi-database-url)


;;; [ company-edbi ]

(add-to-list 'company-backends 'company-edbi)



(require 'init-my-prog-lang-database-sqlite)
(require 'init-my-prog-lang-database-mongodb)
(require 'init-my-prog-lang-database-redis)


(provide 'init-my-prog-lang-database)

;;; init-my-prog-lang-database.el ends here
