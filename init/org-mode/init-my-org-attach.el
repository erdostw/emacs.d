;;; init-my-org-attach.el --- init for Org attach
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-attach ] -- Manage file attachments to org-mode tasks.

(require 'org-attach)

(setq org-attach-archive-delete 'query)

;; auto commit when Org file is in git repository.
(setq org-attach-commit t)

;;; don't auto add tag "ATTACH"
(setq org-attach-auto-tag nil)

;;; [ org-screenshot ] -- Take and manage screenshots in Org-mode files.

(use-package org-plus-contrib
  :ensure t
  :no-require t
  :ensure-system-package scrot
  :config
  (require 'org-screenshot)
  ;; (setq org-screenshot-command-line "scrot -d 5 -s %f") ; "import %f",
  (add-hook 'org-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c o M-s") 'org-screenshot)))
  )

;;; [ org-download ] -- drag and drop images to Emacs org-mode.

(use-package org-download
  :ensure t
  :init
  (unless (boundp 'org-download-prefix)
    (define-prefix-command 'org-download-prefix))
  (define-key Org-prefix (kbd "d") 'org-download-prefix)

  (define-key org-download-prefix (kbd "i") 'org-download-image)
  (define-key org-download-prefix (kbd "s") 'org-download-screenshot)
  (define-key org-download-prefix (kbd "y") 'org-download-yank)
  (define-key org-download-prefix (kbd "d") 'org-download-delete)
  (define-key org-download-prefix (kbd "e") 'org-download-edit)

  (define-key org-mode-map (kbd "<drag-n-drop>") 'org-download-dnd)
  (define-key org-mode-map (kbd "<C-drag-n-drop>") 'org-download-dnd)
  (define-key org-mode-map (kbd "<M-drag-n-drop>") 'org-download-dnd)
  :config
  (setq org-download-screenshot-method "scrot -s %s"
        org-download-method 'attach ; 'attach, 'directory,
        ;; if you don't want the #+DOWNLOADED: annotation in your Org document
        org-download-annotate-function (lambda (_) "")
        org-download-backend t ; url-retrieve (t), wget, curl.
        ;; org-download-heading-lvl
        ;; org-download-timestamp "_%Y-%m-%d_%H:%M:%S"
        org-download-image-dir "data/images" ; nil: default to "."
        ;; org-download-image-width nil ; use #+attr_html: :width
        ;; org-download-img-regex-list '("<img +src=\"" "<img +\\(class=\"[^\"]+\"\\)? *src=\"")
        )

  (org-download-enable)
  )

;;; [ org-board ] -- Org mode's web archiver.

(use-package org-board
  :ensure t
  :defer t
  :init
  (unless (boundp 'org-board-prefix)
    (define-prefix-command 'org-board-prefix))
  (define-key Org-prefix (kbd "C-b") 'org-board-prefix)

  (define-key org-board-prefix (kbd "a") 'org-board-new)
  (define-key org-board-prefix (kbd "n") 'org-board-new)
  (define-key org-board-prefix (kbd "C-a") 'org-board-archive)
  (define-key org-board-prefix (kbd "r") 'org-board-archive-dry-run)
  (define-key org-board-prefix (kbd "o") 'org-board-open)
  (define-key org-board-prefix (kbd "d") 'org-board-diff)
  (define-key org-board-prefix (kbd "C-d") 'org-board-delete-all)
  )


(provide 'init-my-org-attach)

;;; init-my-org-attach.el ends here
