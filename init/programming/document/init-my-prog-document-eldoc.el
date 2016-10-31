;;; init-my-prog-document-eldoc.el --- init for ElDoc
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ ElDoc ] --- show you the argument list of the function call you are currently writing in the echo area.

(require 'eldoc)

;; (global-eldoc-mode t)

(dolist (hook
         '(prog-mode-hook
           emacs-lisp-mode-hook
           lisp-interaction-mode-hook
           lisp-mode-hook
           ielm-mode-hook
           ))
  (add-hook hook #'eldoc-mode))

(set-face-attribute 'eldoc-highlight-function-argument nil
                    :underline t :foreground "cyan"
                    :weight 'bold)


;;; ElDoc with most `paredit' command.
;;; whenever the listed commands are used, ElDoc will automatically refresh the minibuffer.
(eldoc-add-command 'paredit-backward-delete
                   'paredit-close-round)


;;; [ suggestion-box ] -- show tooltip on the cursor with convenient information.

(use-package suggestion-box
  :ensure t
  :defer t)


(provide 'init-my-prog-document-eldoc)

;;; init-my-prog-document-eldoc.el ends here
