;;; init-emacs-notify.el --- init for notification
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ notifications ]

;;; Usage:
;;
;; - (notifications-get-server-information)
;; - (notifications-notify :title "Title" :body "text")
;; - (notifications-notify :bus ...)

(require 'notifications)


;;; [ alert ] -- A Growl-like alerts notifier for Emacs.

;; (use-package alert
;;   :ensure t
;;   :config
;;   (setq alert-default-style 'libnotify ; 'notifications
;;         alert-reveal-idle-time 15
;;         alert-persist-idle-time 900
;;         alert-fade-time 5
;;         )
;;   )


(provide 'init-emacs-notify)

;;; init-emacs-notify.el ends here
