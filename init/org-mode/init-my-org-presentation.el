;;; init-my-org-presentation.el --- init for Org presentation
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-present ]

(use-package org-present
  ;; :ensure t
  :config
  ;; Precise behaviour of org-present during start and quit is controlled from
  ;; hooks. The following will enlarge text, show images, hide the cursor and
  ;; make the buffer read-only:
  (add-hook 'org-present-mode-hook
            '(lambda ()
               (org-present-big)
               (org-display-inline-images)
               (org-present-hide-cursor)
               (org-present-read-only)

               ;; bind [SPACE] to navigate to next slice.
               (define-key org-present-mode-keymap (kbd "SPC") 'org-present-next)
               ))
  (add-hook 'org-present-mode-quit-hook
            '(lambda ()
               (org-present-small)
               (org-remove-inline-images)
               (org-present-show-cursor)
               (org-present-read-write)))

  (defun my-org-present ()
    "Toggle org-present."
    (interactive)
    (if org-present-mode
        (org-present-quit)
      (org-present)))

  (define-key my-org-prefix (kbd "C-s") 'my-org-present)
  )


;;; [ org-tree-slide ] -- A presentation tool for org-mode based on the visibility of outline trees.

(use-package org-tree-slide
  :ensure t
  :config
  (setq org-tree-slide-header t
        org-tree-slide-cursor-init t
        org-tree-slide-skip-done nil
        org-tree-slide-slide-in-effect t
        org-tree-slide-heading-emphasis t
        org-tree-slide-modeline-display 'outside
        org-tree-slide-fold-subtrees-skipped t)
  
  ;; profiles
  ;; (org-tree-slide-simple-profile)
  (org-tree-slide-presentation-profile)
  ;; (org-tree-slide-narrowing-control-profile)

  (define-key my-org-prefix (kbd "C-s") 'org-tree-slide-mode)
  ;; (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)

  (define-key org-tree-slide-mode-map (kbd "C-SPC") 'org-tree-slide-move-next-tree)
  ;; (define-key org-tree-slide-mode-map (kbd "SPC") 'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "S-SPC") 'org-tree-slide-move-previous-tree)
  )


;;; [ ox-reveal ] -- Org-mode export with Reveal.js.

;;; Usage:
;;
;; [C-c C-e R B]

(use-package ox-reveal
  :ensure t
  :config
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
        ;; (concat user-emacs-directory "init/org-mode/reveal.js")
        ;; "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
        org-reveal-hlevel 1)
  )


(provide 'init-my-org-presentation)

;;; init-my-org-presentation.el ends here
