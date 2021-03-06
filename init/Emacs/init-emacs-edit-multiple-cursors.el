;;; init-emacs-edit-multiple-cursors.el --- init for multiple cursors
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'mc-prefix)
  (define-prefix-command 'mc-prefix))
(define-key editing-prefix (kbd "c") 'mc-prefix)

;;;_ [ iedit ] -- Edit multiple regions simultaneously in a buffer or a region

(use-package iedit
  :ensure t
  :defer t
  :bind (:map editing-prefix ("e" . iedit-mode) ("C-e" . iedit-dwim))
  :preface (setq iedit-toggle-key-default (kbd "C-x e e"))
  :init
  (defun iedit-dwim (arg)
    "If ARG, start iedit but use \\[narrow-to-defun] to limit its scope."
    (interactive "P")
    (if arg
        (iedit-mode)
      (save-excursion
        (save-restriction
          (widen)
          ;; this function determines the scope of `iedit-start'.
          (if iedit-mode
              (iedit-done)
            ;; `current-word' can of course be replaced by other
            ;; functions.
            (narrow-to-defun)
            (iedit-start (current-word) (point-min) (point-max)))))))
  ;; disable `aggressive-fill-paragraph-mode' when in `rectangular-region-mode' (`set-rectangular-region-anchor').
  (when (featurep 'aggressive-fill-paragraph)
    (defun iedit-disable-aggressive-fill-paragraph-mode ()
      "Disable `aggressive-fill-paragraph-mode' when in `iedit'."
      (aggressive-fill-paragraph-mode -1)
      (message "aggressive-fill-paragraph-mode disable now."))
    (advice-add 'set-rectangular-region-anchor :before 'iedit-disable-aggressive-fill-paragraph-mode)))

;;;_ [ multiple-cursors ]

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind (:map mc-prefix
              ("a" . mc/mark-all-dwim)
              ("r" . set-rectangular-region-anchor)
              ("m" . mc/mark-next-like-this)
              ("u" . mc/unmark-next-like-this)
              ("l" . mc/edit-lines)
              ("a" . mc/edit-beginnings-of-lines)
              ("e" . mc/edit-ends-of-lines)
              ("n" . mc/insert-numbers)
              ("s" . mc/sort-regions)
              ("R" . mc/reverse-regions))
  ;; :custom ((mc/keymap "C-c c"))
  :bind (:map mc/keymap ("C-'" . mc-hide-unmatched-lines-mode))
  :init
  (unless (boundp 'mc/mark-prefix)
    (define-prefix-command 'mc/mark-prefix))
  (define-key mc-prefix (kbd "m") 'mc/mark-prefix)

  (define-key mc/mark-prefix (kbd "a a") 'mc/mark-all-like-this-dwim)
  (define-key mc/mark-prefix (kbd "a l") 'mc/mark-all-like-this)
  (define-key mc/mark-prefix (kbd "a w") 'mc/mark-all-words-like-this)
  (define-key mc/mark-prefix (kbd "a s") 'mc/mark-all-symbols-like-this)
  (define-key mc/mark-prefix (kbd "a r") 'mc/mark-all-in-region)
  (define-key mc/mark-prefix (kbd "a f") 'mc/mark-all-like-this-in-defun)
  (define-key mc/mark-prefix (kbd "a F") 'mc/mark-all-words-like-this-in-defun)
  (define-key mc/mark-prefix (kbd "a S") 'mc/mark-all-symbols-like-this-in-defun)
  (define-key mc/mark-prefix (kbd "t") 'mc/mark-sgml-tag-pair)

  (define-key mc/mark-prefix (kbd "n n") 'mc/mark-next-like-this)
  (define-key mc/mark-prefix (kbd "n w") 'mc/mark-next-word-like-this)
  (define-key mc/mark-prefix (kbd "n s") 'mc/mark-next-symbol-like-this)
  (define-key mc/mark-prefix (kbd "p p") 'mc/mark-previous-like-this)
  (define-key mc/mark-prefix (kbd "p w") 'mc/mark-previous-word-like-this)
  (define-key mc/mark-prefix (kbd "p s") 'mc/mark-previous-symbol-like-this)

  (if (featurep 'visual-regexp)
      (define-key mc/mark-prefix (kbd "v") 'vr/mc-mark))
  ;; `vr/select-mc-mark', `vr/select-replace', `vr/select-query-replace' etc.

  (setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory)))


(provide 'init-emacs-edit-multiple-cursors)

;;; init-emacs-edit-multiple-cursors.el ends here
