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
  :delight projectile-mode
  :init
  ;; nil: disable caching to fix TRAMP hang on sending password
  (setq projectile-enable-caching nil
        projectile-file-exists-remote-cache-expire '(* 60 30)
        projectile-completion-system 'ivy
        projectile-use-git-grep t)
  ;; test
  (setq projectile-create-missing-test-files t)
  :config
  (projectile-global-mode 1)
  ;; (add-hook 'prog-mode-hook 'projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;;; [ projectile-variable ] -- store project local variables.

(use-package projectile-variable
  :ensure t
  :defer t)

;;; [ project-shells ] -- manage the shell buffers for each project.

;; (use-package project-shells
;;   :ensure t
;;   :defer t
;;   :preface (setq project-shells-keymap-prefix "C-c p M-!")
;;   :init (global-project-shells-mode 1))


(provide 'init-prog-project)

;;; init-prog-project.el ends here
