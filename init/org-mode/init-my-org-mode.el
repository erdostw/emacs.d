;;; init-my-org-mode.el --- init for Org-mode
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'my-org-prefix)
  (define-prefix-command 'my-org-prefix))
(global-set-key (kbd "C-c o") 'my-org-prefix)


;; (use-package org
;;   :ensure t
;;   :mode (("\\.org$" . org-mode))
;;   )


;;; latest version
;; NOTE: also pre-load in `init-package.el'
(use-package org
  :load-path "~/Code/Emacs/org-mode/lisp/"
  :pin manual
  ;; :quelpa (org :fetcher git :repo "~/Code/Emacs/org-mode/lisp/")
  :mode (("\\.org$" . org-mode))
  :config
  (load "~/Code/Emacs/org-mode/lisp/org.el")
  )

(use-package org-plus-contrib
  :load-path "~/Code/Emacs/org-mode/contrib/lisp/"
  :pin manual
  ;; :quelpa (org-plus-contrib :fetcher git :repo "~/Code/Emacs/org-mode/contrib/lisp/")
  :config
  )

;;; [ Org Modules ]
;; Modules that should always be loaded together with org.el.
(setq org-modules
      '(org-pcomplete
        org-faces
        ;; org-fstree
        org-table org-compat
        org-protocol
        org-timer org-clock org-habit org-notify
        org-info org-bibtex org-docview
        org-plot
        org-irc ; org-gnus org-mhe org-rmail
        ;; org-w3m
        ))


(require 'init-my-org-functions)
(require 'init-my-org-document-structure)
(require 'init-my-org-view)
(require 'init-my-org-face)
(require 'init-my-org-face-extra)
(require 'init-my-org-keybindings)
(require 'init-my-org-complete)
(require 'init-my-org-table)
(require 'init-my-org-hyperlink)
(require 'init-my-org-todo)
(require 'init-my-org-tag)
(require 'init-my-org-property)
(require 'init-my-org-time)
(require 'init-my-org-clock)
(require 'init-my-org-babel)
(require 'init-my-org-latex)
(require 'init-my-org-image)
(require 'init-my-org-capture)
(require 'init-my-org-agenda)
(require 'init-my-org-export)
(require 'init-my-org-publish)
(require 'init-my-org-search)
(require 'init-my-org-attach)
(require 'init-my-org-hacking)
(require 'init-my-org-extensions)
(require 'init-my-org-programming)
(require 'init-my-org-presentation)
(require 'init-my-org-trello)
(require 'init-my-org-contacts)
(require 'init-my-org-password)
(require 'init-my-org-drill)
(require 'init-my-org-mobile)


(provide 'init-my-org-mode)

;;; init-my-org-mode.el ends here
