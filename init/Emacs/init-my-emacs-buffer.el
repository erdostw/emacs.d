;;; init-my-emacs-buffer.el --- init Emacs buffer settings.

;;; Commentary:



;;; Code:

;;; Auto-reload external file changes

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)



(setq buffers-menu-max-size 30)


;;; [uniquify] -- meaningful names for buffers with the same name

(require 'uniquify)

(after 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets
        uniquify-separator " • "
        uniquify-after-kill-buffer-p t
        uniquify-ignore-buffers-re "^\\*" ; don't muck with special buffers
        ))


;;; [ recentf ]

(require 'recentf)
(recentf-mode)
(after 'recentf
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 1000
        recentf-exclude '("/tmp/" "/ssh:")))



(provide 'init-my-emacs-buffer)

;;; init-my-emacs-buffer.el ends here
