;;; init-my-emacs-help.el --- init Emacs's help settings.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; (setq text-quoting-style nil)

;;; [ Info ]

;; (require 'info)

(add-to-list 'Info-directory-list
             (expand-file-name "info/" user-emacs-directory))
;; - `Info-default-directory-list'

;; let `[s]' search like =isearch= for incremental search.
(setq Info-isearch-search t)

;; - `Info-mode-hook'


;;; [ info+ ]

(use-package info+
  :ensure t
  :defer t
  :config
  (setq Info-breadcrumbs-in-header-flag t
        ;; Info-display-node-header-fn
        Info-fit-frame-flag t
        Info-fontify-angle-bracketed-flag t
        Info-fontify-quotations-flag t
        Info-fontify-reference-items-flag t
        Info-fontify-single-quote-flag t
        Info-saved-nodes t
        ;; Info-subtree-separator "
        ;; * "
        )

  ;; ----------------- Faces -----------------------
  ;;  Faces defined here:
  ;;
  ;;    `info-command-ref-item', `info-constant-ref-item', `info-file',
  ;;    `info-function-ref-item',`info-macro-ref-item', `info-menu',
  ;;    `info-node', `info-quoted-name', `info-reference-item',
  ;;    `info-single-quote', `info-special-form-ref-item',
  ;;    `info-string', `info-syntax-class-item',
  ;;    `info-user-option-ref-item', `info-variable-ref-item',
  ;;    `info-xref'.
  (set-face-attribute 'info-quoted-name nil
                      :background "#004A5D" :foreground "white"
                      :box '(:color "cyan" :line-width 1 :style nil)
                      :family "DejaVu Sans Mono"
                      :bold nil)
  (set-face-attribute 'info-menu-header nil
                      :foreground "green"
                      :weight 'extra-bold :height 150
                      :box '(:color "black" :line-width 1 :style 'released-button))
  (set-face-attribute 'info-xref nil
                      :foreground "dark cyan"
                      :weight 'bold
                      :underline t)
  (set-face-attribute 'info-xref-visited nil
                      :foreground "#444444"
                      :weight 'normal)
  (set-face-attribute 'info-function-ref-item nil
                      :foreground "cyan" :background "black"
                      :overline t
                      :weight 'bold)
  (set-face-attribute 'info-variable-ref-item nil
                      :foreground "orange" :background "black"
                      :overline t
                      :weight 'bold)
  (set-face-attribute 'info-command-ref-item nil
                      :foreground "#7474FFFF7474" :background "black"
                      :overline t
                      :weight 'bold)
  (set-face-attribute 'info-reference-item nil
                      :foreground "white" :background "black"
                      )
  (set-face-attribute 'info-string nil
                      :foreground "cyan")
  )


;;; [ help.el ]

(use-package help+
  :ensure t
  :defer t)

(use-package help-mode+
  :ensure t
  :defer t)

(use-package help-fns+
  :ensure t
  :defer t)



(setq suggest-key-bindings t) ; show the /equivalent/ key binding when [M-x] command has one.

(define-key global-map (kbd "C-h u") 'manual-entry) ; Unix


(provide 'init-my-emacs-help)

;;; init-my-emacs-help.el ends here
