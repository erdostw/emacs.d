;;; init-emacs-theme.el --- Init for Themes
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ X Resources ]

(setq inhibit-x-resources t)

;;; [ font lock ]

(global-font-lock-mode t)

(autoload 'color-lighten-name "color.el")
(autoload 'color-darken-name "color.el")

;;; [ custom theme ]

(defcustom load-theme-before-hook nil
  "Functions to run before load theme."
  :type 'hook)

(defcustom load-theme-after-hook nil
  "Functions to run after load theme."
  :type 'hook)

(defun load-theme-hook-wrapper (origin-func theme &rest args)
  "A wrapper of hooks around `load-theme'."
  (mapc #'disable-theme custom-enabled-themes)
  (run-hook-with-args 'load-theme-before-hook theme)
  (apply origin-func theme args)
  (run-hook-with-args 'load-theme-after-hook theme))

(advice-add 'load-theme :around #'load-theme-hook-wrapper)

;;; [ leuven-theme ]

(use-package leuven-theme
  :load-path "~/Code/Emacs/leuven-theme/"
  :config (load-theme 'leuven t))

;;; [ one-themes ] -- One color scheme.

(use-package one-themes
  :load-path "~/Code/Emacs/one-themes"
  :config (when (null custom-enabled-themes)
            (load-theme 'one-dark t)))

;;; [ circadian ] -- Theme-switching based on daytime.

(use-package circadian
  :ensure t
  :config
  (setq calendar-location-name "Shaoxing Town"
        calendar-time-zone +480
        calendar-latitude 29.72
        calendar-longitude 120.20)
  ;; NOTE: make sure to use `:defer' keyword for theme `use-package'.
  (setq circadian-themes '((:sunrise . leuven)
                           (:sunset . one-dark)))
  (circadian-setup))


(provide 'init-emacs-theme)

;;; init-emacs-theme.el ends here
