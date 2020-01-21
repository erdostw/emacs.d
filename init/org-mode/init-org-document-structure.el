;;; init-org-document-structure.el --- init for Org Document Structure
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(setq org-special-ctrl-a/e t)
(setq org-fontify-whole-heading-line t)
(setq org-fontify-done-headline t)
(setq org-hide-emphasis-markers t)

;;; [ Org faces ]

(with-eval-after-load 'org-faces
  (set-face-attribute 'org-document-title nil
                      :family "Comic Sans MS"
                      :height 170)
  (set-face-attribute 'org-level-1 nil
                      :inherit 'variable-pitch
                      :family "Comic Sans MS"
                      :weight 'bold :height 130
                      :background (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light
                                     (color-darken-name (face-background 'default) 5))
                                    ('dark
                                     (color-lighten-name (face-background 'default) 3))))
  (set-face-attribute 'org-level-2 nil
                      :inherit 'org-level-1
                      :family "DejaVu Sans Mono"
                      :height 130)
  (set-face-attribute 'org-level-3 nil
                      :inherit 'org-level-2
                      :height 130)
  (set-face-attribute 'org-level-4 nil
                      :inherit 'org-level-3
                      :family "DejaVu Sans"
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :inherit 'org-level-4)
  (set-face-attribute 'org-level-6 nil
                      :inherit 'org-level-5)
  (set-face-attribute 'org-level-7 nil
                      :inherit 'org-level-6)
  (set-face-attribute 'org-headline-done nil
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light
                                     (color-darken-name (face-background 'default) 20))
                                    ('dark
                                     (color-lighten-name (face-background 'default) 20))))
  (set-face-attribute 'org-agenda-done nil
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light
                                     (color-darken-name (face-background 'default) 20))
                                    ('dark
                                     (color-lighten-name (face-background 'default) 20))))
  (set-face-attribute 'org-code nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-verbatim nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil
                      :inherit 'fixed-pitch
                      :height 1.0))

;;; [ priority ]

(setq org-priority-faces
      '((?A .
            (:foreground "#222222"
                         :background "orchid"
                         :box '(:color "dark gray" :line-width -1)))
        (?B .
            (:foreground "dark gray"
                         :background "dark slate blue"
                         :box '(:color "dark gray" :line-width -1)))
        (?C .
            (:foreground "dim gray"
                         :background "gray"
                         :box '(:color "dark gray" :line-width -1)))))

;;; List

(setq org-hierarchical-todo-statistics nil
      org-checkbox-hierarchical-statistics nil)

;; * Column View::

;; (setq org-columns-default-format
;;       "%25ITEM %TODO %3PRIORITY %TAGS %6effort(EFFORT){:}")

;; setup column views for effort estimates
(setq org-columns-default-format
      "%50ITEM(Task) %8TODO %1PRIORITY %14TIMESTAMP_IA(TimeStamp) %Effort(Effort){:} %CLOCKSUM"
      ;; Default column view headings
      ;; - %ITEM(Task) :: Headline (where (Task) is the column head)
      ;; - %PRIORITY :: Priority
      ;; - %TAGS :: tags
      ;; - %ITEMSTAMP_IA :: Timestamp
      ;; - %Effort(Effort){:} :: Effort
      ;; - %CLOCKSUM :: Clock Sum
      )

;; This will be combined with constant `org-global-properties-fixed'
(add-to-list 'org-global-properties '("Effort" . "0:30 0:45 1:00 1:30 2:00"))
(add-to-list 'org-global-properties '("AUTHOR" . "stardiviner"))

;; * Footnotes::                   How footnotes are defined in Org's syntax

(setq org-footnote-auto-label 'confirm
      org-footnote-auto-adjust t
      org-footnote-define-inline nil ; t: define foot inline, instead of separate section.
      org-footnote-section nil       ; let footnotes can be under any headline section.
      org-footnote-fill-after-inline-note-extraction t)

;;; [ Structure Templates ] --  ; expand snippet <[s]

(use-package org-tempo
  :defer t)
;; (add-to-list 'org-structure-template-alist '("?" . "..."))
;; (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
;; `tempo-define-template'

;;; [ Entities ]

(defun org-insert-entity-with-ivy ()
  "Insert an org-entity using Ivy."
  (interactive)
  (ivy-read "Entity: "
            (loop for element in (append org-entities org-entities-user)
			            when (not (stringp element))
			            collect
			            (cons
			             (format "%10s | %s | %s | %s"
				                   (car element) ;name
				                   (nth 1 element) ; latex
				                   (nth 3 element) ; html
				                   (nth 6 element)) ;utf-8
			             element))
	          :require-match t
	          :action '(1
		                  ("u" (lambda (element) (insert (nth 6 (cdr element)))) "utf-8")
		                  ("o" (lambda (element) (insert "\\" (cadr element))) "org-entity")
		                  ("l" (lambda (element) (insert (nth 1 (cdr element)))) "latex")
		                  ("h" (lambda (element) (insert (nth 3 (cdr element)))) "html"))))

;;; [ Table Of Contents (TOC) ]

;;; [ org-make-toc ] -- Automatic tables of contents for Org files.

;; (use-package org-make-toc
;;   :ensure t
;;   :defer t
;;   :commands (org-make-toc))

;;; [ orgtbl-aggregate ] -- create an aggregated Org table from another one.

(use-package orgtbl-aggregate
  :ensure t
  :commands (org-insert-dblock org-insert-dblock:aggregate)
  :config
  ;; add `orgtbl-aggregate' dynamic blocks into list.
  (org-dynamic-block-define "columnview" 'org-insert-dblock:columnview)
  (org-dynamic-block-define "aggregate" 'org-insert-dblock:aggregate)
  (org-dynamic-block-define "invoice" 'org-insert-dblock:invoice)
  (org-dynamic-block-define "join" 'org-insert-dblock:join)
  (org-dynamic-block-define "org-gantt" 'org-insert-dblock:org-gantt)
  (org-dynamic-block-define "propview" 'org-insert-dblock:propview)
  (org-dynamic-block-define "transpose" 'org-insert-dblock:transpose))

;;; [ org-lint ] -- Org-mode linter. [M-x org-lint]

;; (require 'org-lint)

(add-to-list 'display-buffer-alist
             '("^\\*Org Lint\\*" . (display-buffer-below-selected)))


(provide 'init-org-document-structure)

;;; init-org-document-structure.el ends here
