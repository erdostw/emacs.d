;;; init-prog-vcs-git-gutter.el --- init for Git gutter
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'git-gutter-prefix)
  (define-prefix-command 'git-gutter-prefix))
(global-set-key (kbd "M-g g") 'git-gutter-prefix)

;;; [ git-gutter ]

;; (use-package git-gutter
;;   :ensure t
;;   :defer t)

(use-package ivy
  :ensure t
  :defer t)

(defun my-git-gutter-reshap (gutter)
  "Re-shape gutter for `ivy-read'."
  (let* ((linenum-start (aref gutter 3))
         (linenum-end (aref gutter 4))
         (target-line "")
         (target-linenum 1)
         (tmp-line "")
         (max-line-length 0))
    (save-excursion
      ;; find out the longest stripped line in the gutter
      (while (<= linenum-start linenum-end)
        (goto-line linenum-start)
        (setq tmp-line (replace-regexp-in-string "^[ \t]*" ""
                                                 (buffer-substring (line-beginning-position)
                                                                   (line-end-position))))
        (when (> (length tmp-line) max-line-length)
          (setq target-linenum linenum-start)
          (setq target-line tmp-line)
          (setq max-line-length (length tmp-line)))

        (setq linenum-start (1+ linenum-start))))
    ;; build (key . linenum-start)
    (cons (format "%s %d: %s"
                  (if (eq 'deleted (aref gutter 1)) "-" "+")
                  target-linenum target-line)
          target-linenum)))

(defun my-git-gutter-goto ()
  (interactive)
  (if git-gutter:diffinfos
      (let* ((collection (mapcar 'my-git-gutter-reshap
                                 git-gutter:diffinfos)))
        (ivy-read "git-gutters:"
                  collection
                  :action (lambda (linenum)
                            (goto-line linenum))))
    (message "NO git-gutters!")))

(define-key prog-vcs-prefix (kbd "m g") 'my-git-gutter-goto)


;; [ git-gutter-plus / git-gutter+]

(use-package git-gutter+
  :ensure t
  :init
  ;; (add-hook 'prog-mode-hook #'git-gutter+-mode)
  (global-git-gutter+-mode t)
  :bind (:map git-gutter-prefix
              ("t" . git-gutter+-mode) ; Turn on/off in the current buffer
              ("T" . global-git-gutter+-mode) ; Turn on/off globally
              ;; jump between hunks
              ("n" . git-gutter+-next-hunk)
              ("p" . git-gutter+-previous-hunk)
              ;; actions on hunks
              ("d" . git-gutter+-show-hunk-inline-at-point)
              ("D" . git-gutter+-show-hunk) ; diff
              ("=" . git-gutter+-popup-hunk)
              ("r" . git-gutter+-revert-hunk)
              ;; stage hunk at point
              ;; if region is active, stage all hunk lines within the region.
              ("s" . git-gutter+-stage-hunks)
              ("c" . magit-commit)
              ("C" . git-gutter+-stage-and-commit)
              ("u" . git-gutter:update-all-windows)
              
              :map prog-vcs-prefix
              ("m t" . git-gutter+-mode) ; Turn on/off in the current buffer
              ("m T" . global-git-gutter+-mode) ; Turn on/off globally
              ;; jump between hunks
              ("m n" . git-gutter+-next-hunk)
              ("m p" . git-gutter+-previous-hunk)
              ;; actions on hunks
              ("m d" . git-gutter+-show-hunk-inline-at-point)
              ("m =" . git-gutter+-show-hunk) ; diff
              ("m D" . git-gutter+-show-hunk) ; diff
              ("m r" . git-gutter+-revert-hunk)
              ;; stage hunk at point
              ;; if region is active, stage all hunk lines within the region.
              ("m s" . git-gutter+-stage-hunks)
              ("m c" . git-gutter+-commit)
              ("m C" . git-gutter+-stage-and-commit)
              ("m u" . git-gutter:update-all-windows)
              )
  :config
  (setq git-gutter+-disabled-modes '(asm-mode image-mode)
        ;; hide gutter if there are no changes
        git-gutter+-hide-gutter t
        ;; pass option to 'git diff' command: -w: ignore all spaces
        git-gutter+-diff-option "-w")
  )



(provide 'init-prog-vcs-git-gutter)

;;; init-prog-vcs-git-gutter.el ends here