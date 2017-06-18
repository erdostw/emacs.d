;;; init-my-org-document-structure.el --- init for Org Document Structure
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; * Outlines::                    Org is based on Outline mode

(let ((org-dir "~/Org"))
  (if (file-exists-p org-dir)
      (setq org-directory org-dir)
    (make-directory org-dir)))

(setq org-blank-before-new-entry '((heading . t)
                                   (plain-list-item . auto))
      org-ascii-headline-spacing '(1 . 2)
      org-cycle-separator-lines 2
      org-adapt-indentation t   ; adapt indentation to outline node level.
      )


(setq org-special-ctrl-a/e t)


;; * Headlines::                   How to typeset Org tree headlines


;; * Plain Lists::

(setq org-list-allow-alphabetical t
      org-list-empty-line-terminates-plain-lists nil ; need 2 empty lines
      )

(setq org-columns-default-format
      "%25ITEM %TODO %3PRIORITY %TAGS %6effort(EFFORT){:}")

;; * Table

;; * Plotting

;; [ org-plot ] -- Plotting Tables in Org-mode.

(require 'org-plot)
(require 'orgtbl-ascii-plot)


;; * Visibility cycling::          Show and hide, much simplified



;; * Motion::                      Jumping to other headlines



;; * Structure editing::           Changing sequence and level of headlines



;; * Sparse trees::                Matches embedded in context

(setq org-highlight-sparse-tree-matches t)
(setq org-sparse-tree-open-archived-trees nil)


;; * Drawers::                     Tucking stuff away

;; (setq org-global-properties ; will be combined with constant `org-global-properties-fixed'
;;       '(("Effort" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
;;         ("Title" . nil)
;;         ("Author" . "stardiviner")
;;         ))



;; * Blocks::                      Folding blocks



;; * Footnotes::                   How footnotes are defined in Org's syntax

(setq org-footnote-auto-label 'confirm
      org-footnote-auto-adjust nil
      org-footnote-define-inline nil ; define foot-note inline, instead of separate section.
      org-footnote-fill-after-inline-note-extraction t
      ;; org-footnote-section "Footnotes"
      ;; org-footnote-tag-for-non-org-mode-files "Footnotes:"
      )


;; * Orgstruct mode::              Structure editing outside Org



;; * Org syntax::                  Formal description of Org's syntax

;;; [ Template ]

(add-to-list 'org-structure-template-alist '("n" "#+NAME: ?"))



(provide 'init-my-org-document-structure)

;;; init-my-org-document-structure.el ends here
