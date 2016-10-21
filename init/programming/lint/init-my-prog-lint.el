;;; init-my-prog-lint.el --- init Programming Lint

;;; Commentary:



;;; Code:


(unless (boundp 'my-prog-lint-map)
  (define-prefix-command 'my-prog-lint-map))

(add-hook 'prog-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c !") 'my-prog-lint-map)
            (define-key my-prog-lint-map (kbd "!") 'flycheck-buffer)
            (define-key my-prog-lint-map (kbd "b") 'flycheck-buffer)
            ))


;;; [ FlyCheck ] --- modern on-the-fly syntax checking

(use-package flycheck
  :ensure t
  :defer t
  :commands flycheck-mode
  :init
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :config
  (setq-default flycheck-temp-prefix ".flycheck")
  ;; (save idle-change new-line mode-enabled)
  (setq flycheck-check-syntax-automatically '(save new-line)
        flycheck-idle-change-delay 5.0
        flycheck-display-errors-delay 0.9
        flycheck-highlighting-mode 'symbols
        flycheck-indication-mode 'left-fringe
        ;; 'flycheck-fringe-bitmap-double-arrow
        ;; flycheck-display-errors-function 'flycheck-display-error-messages
        flycheck-standard-error-navigation t ; [M-g n/p]
        flycheck-deferred-syntax-check nil
        ;; flycheck-mode-line '(:eval (flycheck-mode-line-status-text))
        flycheck-completing-read-function 'completing-read
        )

  ;; {Emacs Lisp}
  ;; To make Flycheck use the current `load-path'.
  ;; Don't error about "free variable" without (require ??).
  (setq flycheck-emacs-lisp-initialize-packages 'auto
        flycheck-emacs-lisp-load-path 'inherit
        flycheck-emacs-lisp-package-user-dir nil
        )

  ;; {Ruby}
  (setq flycheck-ruby-executable "rubocop"
        ;; flycheck-rubocop-lint-only t
        )

  ;; {clang}
  ;; flycheck-clang-definitions
  ;; flycheck-clang-include-path
  ;; flycheck-clang-includes
  ;; flycheck-clang-language-standard
  ;; flycheck-clang-no-rtti
  ;; flycheck-clang-standard-library
  ;; flycheck-clang-warnings
  ;; flycheck-cppcheck-checks

  (set-face-attribute 'flycheck-info nil
                      :underline '(:color "forest green" :style wave))
  (set-face-attribute 'flycheck-warning nil
                      :underline '(:color "DarkSlateBlue" :style wave))
  (set-face-attribute 'flycheck-error nil
                      :underline '(:color "red" :style wave))
  (set-face-attribute 'flycheck-fringe-info nil
                      :foreground "forest green")
  (set-face-attribute 'flycheck-fringe-warning nil
                      :foreground "DarkSlateBlue")
  (set-face-attribute 'flycheck-fringe-error nil
                      :foreground "red")


  ;; list errors only when has lint errors
  (defun flycheck-list-errors-only-when-errors ()
    "List errors only when has lint errors."
    (if flycheck-current-errors
        (flycheck-list-errors)
      (-when-let (buffer (get-buffer flycheck-error-list-buffer))
        (dolist (window (get-buffer-window-list buffer))
          (quit-window nil window)))))
  ;; (add-hook 'before-save-hook #'flycheck-list-errors-only-when-errors)

  ;; add Django-mode
  ;; (with-eval-after-load 'flycheck
  ;;   (dolist (checker '(python-pylint python-flake8 python-pycompile))
  ;;     (flycheck-add-mode checker 'django-mode)))
  )


;;; [ flycheck-pos-tip ] -- display errors under point using popup.el.

;;; NOTE: This can avoid flycheck tip in minibuffer to override eldoc info.
(use-package flycheck-pos-tip
  :ensure t
  :init
  (with-eval-after-load 'flycheck
    (setq flycheck-display-errors-function 'flycheck-pos-tip-error-messages
          flycheck-pos-tip-timeout 10
          ;; you change change flycheck-pos-tip to use popup.el library.
          ;; default use `pos-tip-show'.
          ;; flycheck-pos-tip-show-function #'flycheck-pos-tip-show
          ))
  )


(provide 'init-my-prog-lint)

;;; init-my-prog-lint.el ends here
