;;; init-emacs-ebook.el --- init for EBook
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ nov ] -- featureful EPUB reader mode.

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (with-eval-after-load "org" ; open Org file: link type EPUB file with nov.el
    (add-to-list 'org-file-apps '("\\.epub\\'" . auto-mode)))
  (define-key nov-mode-map (kbd "q") 'kill-current-buffer))

;;; [ calibredb ] -- Yet Another calibre client for ebook management.

(use-package calibredb
  :ensure t
  :commands (calibredb)
  :custom ((calibredb-root-dir (expand-file-name "~/Calibre Library"))
           (calibredb-format-icons t)))


(provide 'init-emacs-ebook)

;;; init-emacs-ebook.el ends here
