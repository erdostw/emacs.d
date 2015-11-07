;;; init-my-emacs-edit.el --- init Emacs editing
;;; Commentary:

;;; Code:

;;;_ Edit

(delete-selection-mode t)             ; typed text replaces the active selection

;;;_ Rectangle

;;; - [C-x SPC] / [C-x r r m] (custom keybinding) :: `rectangle-mark-mode'


;;;_ [ edit-server ]

;;; Usage:
;;
;; edit browser text-area.

(when (require 'edit-server nil t)
  (setq edit-server-new-frame t)
  (edit-server-start))

(setq edit-server-url-major-mode-alist
      '(("github\\.com" . markdown-mode)
        ("stackoverflow\\.com" . markdown-mode)
        ("segmentfault\\.com" . markdown-mode)
        ))

;;;_ whitespace-mode

;; (require 'whitespace)

;; ;; automatically clean up bad whitespace
;; (setq whitespace-action '(auto-cleanup))
;; ;; only show bad whitespace
;; (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))

;; (whitespace-mode 1)
;; (global-whitespace-mode)


;;;_ Macro

;;; Usage:
;; - [C-x C-k] -- macro prefix.
;; - [C-x (/)] -- start/end macro.
;; - [F3/F4] -- start/end macro or insert counter/repeat.


(require 'init-my-emacs-kill-ring)
(require 'init-my-emacs-region)
(require 'init-my-emacs-edit-electric)
(require 'init-my-emacs-edit-narrow)
(require 'init-my-emacs-edit-tabulate)
(require 'init-my-emacs-edit-multiple-cursors)
(require 'init-my-emacs-edit-sudo)


(provide 'init-my-emacs-edit)

;;; init-my-emacs-edit.el ends here
