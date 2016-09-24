;;; init-my-prog-lang-shell.el --- init for Shell Scripts
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ `sh-mode' (shell-script-mode ]

(setq sh-indentation 2
      sh-basic-offset 2)

;;; [ Bash ]

;;; [ Zsh ]

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; A programmatic way of selecting a flavor when you don't want to use the
;; shebang is doing this in a sh-mode buffer:
(defun my-sh-mode-zsh-setup ()
  "Setup `sh-mode' engine to Zsh."
  (interactive)
  (if (and (buffer-file-name) ; filer out non-file buffers which will returns nil
           (string-match "\\.zsh$" (buffer-file-name)))
      (sh-set-shell "zsh")))

(add-hook 'sh-mode-hook #'my-sh-mode-zsh-setup)


;;; [ company-shell ]

;; (use-package company-shell
;;   :ensure t
;;   :config
;;   ;; (setq company-shell-modes '(sh-mode fish-mode shell-mode eshell-mode))
;;   ;; (setq company-shell-use-help-arg nil)
;;
;;   (dolist (hook '(sh-mode-hook
;;                   shell-mode-hook
;;                   ))
;;     (add-hook hook '(lambda ()
;;                       (setq-local completion-at-point-functions
;;                                   (delq 'sh-completion-at-point-function
;;                                         completion-at-point-functions))
;;                       (setq-local company-minimum-prefix-length 3)
;;                       (my-company-add-backend-locally 'company-shell)
;;                       )))
;;   )


;;; [ bash-completion ]

;; (use-package bash-completion
;;   :ensure t
;;   :config
;;   (bash-completion-setup)
;;   ;; (add-hook 'sh-mode-hook
;;   ;;           '(lambda ()
;;   ;;              (setq-local completion-at-point-functions
;;   ;;                          '(bash-completion-dynamic-complete))))
;;   )


;;; [ insert-shebang ]

;; (use-package insert-shebang
;;   :ensure t
;;   :config
;;   ;; enable it globally
;;   ;; (add-hook 'find-file-hook 'insert-shebang)
;;   ;; only enable it on some modes
;;   (dolist (hook '(sh-mode-hook
;;                   ))
;;     (add-hook hook 'insert-shebang))
;;
;;   (setq insert-shebang-env-path "/usr/bin/env"
;;         insert-shebang-file-types '(("sh" . "bash"))
;;         insert-shebang-custom-headers '(("c" . "#include <stdio.h>")
;;                                         ("R" . "#!/usr/bin/env r"))
;;         ;; insert-shebang-ignore-extensions '("txt" "org" "markdown" "md")
;;         ;; insert-shebang-track-ignored-filename "~/.insert-shebang.log"
;;         ;; insert-shebang-header-scan-limit 6
;;         )
;;   )


;;; disable flycheck in sh-mode to fix suspend in shell script source code file.

(add-hook 'sh-mode-hook
          (lambda ()
            (flycheck-mode -1)))


(provide 'init-my-prog-lang-shell)

;;; init-my-prog-lang-shell.el ends here
