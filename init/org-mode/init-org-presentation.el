;;; init-org-presentation.el --- init for Org presentation
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Beamer ]

;; (require 'ox-beamer)

;;; [ org-tree-slide ] -- A presentation tool for org-mode based on the visibility of outline trees.

(use-package org-tree-slide
  :ensure t
  :defer t
  :init
  (setq org-tree-slide-skip-done nil
        org-tree-slide-heading-emphasis t)
  :config
  ;; profiles
  ;; (org-tree-slide-simple-profile)
  (org-tree-slide-presentation-profile)
  ;; (org-tree-slide-narrowing-control-profile)

  (define-key Org-prefix (kbd "s") 'org-tree-slide-mode)
  (define-key org-tree-slide-mode-map (kbd "<left>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<right>") 'org-tree-slide-move-next-tree)
  )

;;; [ ox-reveal ] -- Org-mode export with Reveal.js.

(use-package ox-reveal
  :ensure t
  :ensure htmlize
  :defer t
  :preface (setq org-reveal-note-key-char nil) ; avoid register old #+BEGIN_NOTES.
  :init
  ;; "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
  ;; (concat user-emacs-directory "init/org-mode/reveal.js")
  (setq org-reveal-root (expand-file-name (concat user-emacs-directory "Org-mode/reveal.js/"))
        org-reveal-single-file t
        org-reveal-theme "blood"
        org-reveal-highlight-css "%r/lib/css/zenburn.css"
        org-reveal-rolling-links t
        org-reveal-default-frag-style t)
  :config
  (add-to-list 'org-reveal-plugins 'highlight)
  (add-to-list 'org-reveal-plugins 'multiplex))

;;; [ ox-spectacle ] -- Exports Org-Mode to Spectacle HTML presentation.

(use-package ox-spectacle
  :ensure t
  :defer t)

;;; [ ox-ioslide ] -- Export org-mode to Google I/O HTML5 slide.

;; (use-package ox-ioslide
;;   :ensure t
;;   :config
;;   (use-package makey
;;     :ensure t)
;;   (require 'ox-ioslide-helper)
;;   )

;;; [ demo-it ] -- demonstrations and presentations with `org-tree-slide' from within Emacs.

(use-package demo-it
  :ensure t
  :defer t)


(provide 'init-org-presentation)

;;; init-org-presentation.el ends here
