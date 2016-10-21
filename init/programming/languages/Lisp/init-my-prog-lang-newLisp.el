;;; init-my-prog-lang-lisp-newLisp.el --- init for newLisp
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ newlisp-mode ]

(use-package newlisp-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.lsp$" . newlisp-mode))
  (add-to-list 'interpreter-mode-alist '("newlisp" . newlisp-mode))
  :config

  (add-hook 'newlisp-mode-hook
            #'(lambda ()
                (make-local-variable 'completion-at-point-functions)
                (add-to-list 'completion-at-point-functions
                             'newlisp-completion-at-point)
                ))
  
  ;; setup `*newlisp*' buffer (`comint-mode' of newLisp)
  (defun newlisp-repl-inferior-buffer-setup ()
    (if (equal (buffer-name) "*newlisp*")
        (progn
          (eldoc-mode t)
          ;; (paredit-mode t)
          (smartparens-strict-mode 1)

          ;; for `company-mode' backend `company-capf'
          (make-local-variable 'completion-at-point-functions)
          (add-to-list 'completion-at-point-functions
                       'newlisp-completion-at-point)
          )))

  (add-hook 'comint-mode-hook 'newlisp-repl-inferior-buffer-setup)
  )


(provide 'init-my-prog-lang-lisp-newLisp)

;;; init-my-prog-lang-lisp-newLisp.el ends here
