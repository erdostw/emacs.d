;;; init-my-prog-lint.el --- init Programming Lint

;;; Commentary:



;;; Code:

(unless (boundp 'linter-prefix)
  (define-prefix-command 'linter-prefix))

(add-hook 'prog-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c !") 'linter-prefix)))


;;; [ FlyCheck ] --- modern on-the-fly syntax checking

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :preface
  (setq flycheck-check-syntax-automatically '(save)
        flycheck-idle-change-delay 5.0
        flycheck-display-errors-delay 0.5)
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :bind (:map linter-prefix
              ;; ("!" . flycheck-mode)
              ;; ("b" . flycheck-buffer)
              :map flycheck-mode-map
              ("M-g M-n" . flycheck-next-error)
              ("M-g M-p" . flycheck-previous-error)
              ("M-g M-l" . flycheck-list-errors))
  :config
  ;; [Emacs Lisp]
  ;; To make Flycheck use the current `load-path'.
  ;; Don't error about "free variable" without (require ??).
  (setq flycheck-emacs-lisp-load-path 'inherit)
  )


;;; [ flycheck-inline ] -- display errors with inline style.

;; (use-package flycheck-inline
;;   :ensure t
;;   :config
;;   (with-eval-after-load 'flycheck
;;     (add-hook 'flycheck-mode-hook #'flycheck-inline-enable))
;;   )


;;; [ flycheck-popup-tip ] -- displaying errors from Flycheck using popup.el.

(use-package flycheck-popup-tip
  :ensure t
  :after flycheck
  :init
  (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))



(provide 'init-my-prog-lint)

;;; init-my-prog-lint.el ends here
