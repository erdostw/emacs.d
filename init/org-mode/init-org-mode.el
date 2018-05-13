;;; init-org-mode.el --- init for Org-mode
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'Org-prefix)
  (define-prefix-command 'Org-prefix))
(global-set-key (kbd "C-c o") 'Org-prefix)


(let ((org-dir "~/Org"))
  (unless (file-exists-p org-dir)
    (make-directory org-dir))
  (setq org-directory org-dir))

(require 'init-org-document-structure)
(require 'init-org-view)

;;; XXX: This heavily affected Emacs Org-mode buffer performance.
(require 'init-org-face)
(defun my-org-mode-set-face (theme)
  "Reload customized faces on `circadian' `THEME' toggling."
  (load "init-org-face"))
(add-hook 'circadian-after-load-theme-hook 'my-org-mode-set-face)

(require 'init-org-keybindings)
(require 'init-org-complete)
(require 'init-org-table)
(require 'init-org-hyperlink)
;; (require 'init-org-bibliography)
(require 'init-org-todo)
(require 'init-org-tag)
(require 'init-org-property)
(require 'init-org-time)
(require 'init-org-clock)
(require 'init-org-babel)
(require 'init-org-latex)
(require 'init-org-image)
(require 'init-org-capture)
(require 'init-org-agenda)
(require 'init-org-export)
(require 'init-org-publish)
(require 'init-org-search)
(require 'init-org-attach)
(require 'init-org-protocol)
(require 'init-org-extensions)
(require 'init-org-programming)
(require 'init-org-mindmap)
(require 'init-org-presentation)
(require 'init-org-contacts)
(require 'init-org-password)
(require 'init-org-drill)
;; (require 'init-org-mobile)
(require 'init-org-trello)



(provide 'init-org-mode)

;;; init-org-mode.el ends here
