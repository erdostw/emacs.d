;;; init-emacs-edit-rectangle.el --- init for rectangle selection.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'rectangle-prefix)
  (define-prefix-command 'rectangle-prefix))
(define-key editing-prefix (kbd "r") 'rectangle-prefix)

(global-unset-key (kbd "C-x r N"))
(global-unset-key (kbd "C-x r t"))
(global-unset-key (kbd "C-x r c"))
(global-unset-key (kbd "C-x r i"))
(global-unset-key (kbd "C-x r n"))
(global-unset-key (kbd "C-x r o"))
(global-unset-key (kbd "C-x r y"))
(global-unset-key (kbd "C-x r k"))
(global-unset-key (kbd "C-x r d"))
(global-unset-key (kbd "C-x r M-w"))

(define-key rectangle-prefix (kbd "r") 'rectangle-mark-mode)
(define-key rectangle-prefix (kbd "m") 'set-rectangular-region-anchor)
(define-key rectangle-prefix (kbd "c") 'copy-rectangle-to-register)
(define-key rectangle-prefix (kbd "M-w") 'copy-rectangle-as-kill)
(define-key rectangle-prefix (kbd "y") 'yank-rectangle)
(define-key rectangle-prefix (kbd "x") 'clear-rectangle)
(define-key rectangle-prefix (kbd "d") 'delete-rectangle)
(define-key rectangle-prefix (kbd "k") 'kill-rectangle)
(define-key rectangle-prefix (kbd "o") 'open-rectangle)
(define-key rectangle-prefix (kbd "t") 'string-rectangle)
(define-key rectangle-prefix (kbd "N") 'rectangle-number-lines)


(provide 'init-emacs-edit-rectangle)

;;; init-emacs-edit-rectangle.el ends here
