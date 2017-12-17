;;; init-my-emacs-window.el --- my Emacs window init

;;; Commentary:


;;; Code:

;;; switch to new splitted window after split.
;;
;; 1. this will break the default action, and affect other window behaviors.
;;
;; (defadvice split-window-below (after switch-to-new-split-below-window activate)
;;   "Switch to new splitted window."
;;   (other-window 1))
;; 2. bind to a function is a better solution.
;;

(define-key global-map (kbd "C-x 2")
  '(lambda ()
     (interactive)
     (split-window-vertically)
     (other-window 1)))

(define-key global-map (kbd "C-x 3")
  '(lambda ()
     (interactive)
     (split-window-horizontally)
     (other-window 1)))


;;; [ display-buffer-alist ]

;; Learn about display actions, see [[info:elisp#Display Action Functions]].

;; (add-to-list 'display-buffer-alist
;;              '("^*Async Shell Command*" . (display-buffer-no-window)))


;;; [ winner ]

(use-package winner
  :config
  (winner-mode 1))

;;; [ ace-window ] -- Quickly switch windows in Emacs.

(use-package ace-window
  :ensure t
  :bind ("C-x C-j" . ace-window)
  :init
  (with-eval-after-load 'dired-x
    (global-set-key (kbd "C-x C-j") 'ace-window))
  :config
  (setq aw-background nil)
  (set-face-attribute 'aw-leading-char-face nil
                      :height 2.5 :weight 'bold)
  (set-face-attribute 'aw-mode-line-face nil
                      :inherit 'mode-line-buffer-id
                      :foreground "cyan")
  )



(provide 'init-my-emacs-window)

;;; init-my-emacs-window.el ends here
