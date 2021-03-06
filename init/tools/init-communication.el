;;; init-communication.el --- init for Communication Tools.

;;; Commentary:



;;; Code:

;;; [ Matrix ] -- An open standard for decentralized persistent communication.

;; (use-package matrix-client
;;   :quelpa (matrix-client-ng :fetcher github :repo "jgkamat/matrix-client-el")
;;   :commands (matrix-client-connect matrix-client-disconnect)
;;   :bind (:matrix-client-mode-map
;;          ("C-c C-b" . matrix-client-switch-buffer))
;;   :init (setq matrix-client-ng-save-token t
;;               matrix-client-use-tracking t
;;               matrix-client-show-images t)
;;   :config
;;   ;; matrix link support for Org.
;;   (defun org-matrix-link-open (room-id)
;;     "Open Matrix ROOM-ID in `matrix-client'."
;;     (matrix-join-room (car matrix-client-sessions) room-id))
;;   (org-link-set-parameters "matrix" :follow #'org-matrix-link-open))

;;; [ slack ] -- Emacs interface for Slack.

;; (use-package slack
;;   :ensure t
;;   :defer t
;;   :init
;;   (setq slack-buffer-emojify nil)
;;   (setq slack-prefer-current-team t))



(provide 'init-communication)

;;; init-communication.el ends here
