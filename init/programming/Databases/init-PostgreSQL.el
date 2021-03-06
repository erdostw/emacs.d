;;; init-PostgreSQL.el --- init for PostgresQL
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ db-pg ] -- key-value Database on PostgreSQL.

(use-package db-pg
  :ensure t
  :defer t)

;;; [ pg ] -- Emacs Lisp interface to the PostgreSQL RDBMS.

(use-package pg
  :ensure t
  :defer t)

;;; [ pgdevenv ] -- manage your PostgreSQL development envs.

(use-package pgdevenv
  :ensure t
  :defer t)


(provide 'init-PostgreSQL)

;;; init-PostgreSQL.el ends here
