;;; init-ivy.el --- init for Ivy-mode
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ ivy ]

(use-package ivy
  :ensure t
  :ensure ivy-hydra ; [C-o], [M-o]
  :defer t
  :delight ivy-mode
  :init (setq ivy-use-virtual-buffers t ; treat recentf, bookmarks as virtual buffers.
              ivy-virtual-abbreviate 'full ; use 'full to fix bookmarks uniquify issue.
              ivy-fixed-height-minibuffer t
              ivy-height 7)
  :config (ivy-mode 1)
  (add-hook 'ivy-mode-hook (lambda () (setq ivy-initial-inputs-alist nil))))

;;; [ ivy-rich ] -- More friendly display transformer for ivy.

(use-package ivy-rich
  :ensure t
  :defer t
  :commands (ivy-rich-mode)
  :init (ivy-rich-mode 1)
  ;;; [ all-the-icons-ivy-rich ] -- Better experience with icons for Ivy.
  (use-package all-the-icons-ivy-rich
    :ensure t
    :init (all-the-icons-ivy-rich-mode 1)
    ;; fix extra spaces between icon and text issue
    :config (setq all-the-icons-ivy-rich-icon-size 0.9)))

;;; [ counsel ]

(use-package counsel
  :ensure t
  :defer t
  :delight counsel-mode
  :bind (([remap yank-pop] . counsel-yank-pop)
         ([remap menu-bar-open] . counsel-tmm) ; [F10] text menu access
         ([remap apropos] . counsel-apropos)
         ("C-x c p" . counsel-list-processes) ; [C-x c p]
         ("C-x c t" . cancel-function-timers) ; [C-x c t]
         ("C-x c c" . counsel-colors-emacs)
         ("C-x c C" . counsel-colors-web)
         ("C-x RET v" . counsel-set-variable) ; [C-x RET v]
         ("C-x RET u" . counsel-unicode-char) ; [C-x RET u]
         ([remap switch-to-buffer] . ivy-switch-buffer) ; [C-x b]
         ;; ([remap switch-to-buffer] . counsel-buffer-or-recentf) ; [C-x b]
         ("M-t" . counsel-git) ; [M-t]
         ("C-c v g g" . counsel-git-grep)
         ([remap grep] . counsel-grep) ; [C-s g]
         ;; ("" . counsel-switch-to-shell-buffer) ; switch to a shell buffer, or create one
         ;; ([remap org-goto] . counsel-org-goto) ; [C-c C-j] completion for Org headings
         ;; ( . counsel-org-goto-all) ; completion for Org headings in all open buffers
         ;; ([remap org-set-tags-command] . counsel-org-tag) ; [C-c C-q]
         ;; ([remap org-agenda-set-tags] . counsel-org-tag-agenda) ; [:]
         ;; ([remap org-capture] . counsel-org-capture)
         ([remap org-attach-open] . counsel-org-file) ; browse all attachments for the current Org file
         ([remap locate] . counsel-locate)
         ("C-x c #" . counsel-linux-app)
         ;; :map read-expression-map ("C-r" . counsel-minibuffer-history) ; in [M-:]
         ;; :map ivy-minibuffer-map ("M-y" . ivy-next-line)
         )
  :preface (unless (boundp 'search-prefix) (define-prefix-command 'search-prefix))
  (define-key search-prefix (kbd "M-g") 'counsel-grep)
  (define-key search-prefix (kbd "M-r") 'counsel-rg) ; [C-u] prompt for dir support
  :init (setq counsel-mode-override-describe-bindings t)
  :config (counsel-mode 1))

;;; [ ivy-posframe ] -- Using posframe to show Ivy.

(use-package ivy-posframe
  :ensure t
  :after ivy
  :hook (after-init . ivy-posframe-mode))


(provide 'init-ivy)

;;; init-ivy.el ends here
