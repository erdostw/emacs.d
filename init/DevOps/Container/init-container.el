;;; init-container.el --- init for Container
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


(unless (boundp 'container-prefix)
  (define-prefix-command 'container-prefix))
(define-key prog-tools-prefix (kbd "c") 'container-prefix)

;;; [ Docker ]

(require 'init-docker)

;;; [ lxc ] -- LXC integration with Emacs.

(use-package lxc
  :ensure t
  :defer t)

(use-package lxc-tramp ; Tramp integration for LXC containers.
  :ensure t
  :defer t)


(provide 'init-container)

;;; init-container.el ends here
