;;; init-prog-project.el --- init Project settings for Emacs

;;; Commentary:


;;; Code:


(unless (boundp 'project-prefix)
  (define-prefix-command 'project-prefix))
(global-set-key (kbd "C-c p") 'project-prefix)


;;; [ projectile ] -- minor mode to assist project management and navigation.

(use-package projectile
  :ensure t
  :defer t
  :delight '(:eval (concat " [" (projectile-project-name) "]"))
  ;; :delight projectile-mode
  :commands (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'ivy)
           (projectile-switch-project-action #'projectile-commander)
           (projectile-use-git-grep t)
           (projectile-create-missing-test-files t))
  :hook (after-init . projectile-mode)
  :init (add-to-list 'display-buffer-alist '("^\\*Projectile Commander Help\\*" . (display-buffer-below-selected))))

;;; [ projectile-variable ] -- store project local variables.

(use-package projectile-variable
  :ensure t
  :defer t
  :commands (projectile-variable-put projectile-variable-get projectile-variable-alist))

;;; [ project-shells ] -- manage the shell buffers for each project.

;; (use-package project-shells
;;   :ensure t
;;   :defer t
;;   :preface (setq project-shells-keymap-prefix "C-c p M-!")
;;   :init (global-project-shells-mode 1))

;;; [ ptemplate ] -- Powerful project (directory) templates for Emacs.

(use-package ptemplate
  :ensure t
  :ensure ptemplate-templates
  :commands (ptemplate-new-project)
  :config (add-to-list 'ptemplate-template-dirs (expand-file-name "ptemplate" user-emacs-directory))
  (eval-after-load 'ptemplate (ptemplate-templates-mode 1)))


(provide 'init-prog-project)

;;; init-prog-project.el ends here
