;;; init-emacs-theme.el --- Init for Themes
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ X Resources ]

(setq inhibit-x-resources t)

;;; [ font lock ]

(global-font-lock-mode t)

(require 'color) ; for `color-lighten-name' and `color-darken-name'

;;; [ leuven-theme ]

(use-package leuven-theme
  :load-path "~/Code/Emacs/leuven-theme/"
  :defer t
  :no-require t
  :init (require 'leuven-theme)
  ;; :config (load-theme 'leuven t)
  )

;;; [ eziam-theme ] -- A mostly monochrome theme, inspired by Tao and Leuven, with dark and light versions.

;; (use-package eziam-theme
;;   :ensure t
;;   :no-require t
;;   :load (eziam-light-theme))

;;; [ spacemacs-theme ] -- Spacemacs default color-theme.

(use-package spacemacs-theme
  :ensure t
  :no-require t
  :defer t
  ;; (load-theme 'spacemacs-dark t)
  )

;;; [ circadian ] -- theme-switching for Emacs based on daytime.

(use-package circadian
  :ensure t
  :config
  (setq calendar-location-name "Shaoxing Town"
        calendar-time-zone +480
        calendar-latitude 29.72
        calendar-longitude 120.20)
  ;; XXX: make sure to use `:defer' keyword for theme `use-package'.
  (setq circadian-themes '((:sunrise . leuven)
                           ;; ("13:00" . spacemacs-light)
                           (:sunset . spacemacs-dark)))
  (circadian-setup))


(defun circadian:builtin-faces (theme)
  "Reload customized faces on `circadian' `THEME' toggling."
  (set-face-attribute 'underline nil
                      :underline (cl-case (alist-get 'background-mode (frame-parameters))
                                   ('light
                                    (color-darken-name (face-background 'default) 50))
                                   ('dark
                                    (color-lighten-name (face-background 'default) 30))))
  (set-face-attribute 'italic nil
                      :slant 'italic
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light "black")
                                    ('dark "white"))
                      :background (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light
                                     (color-darken-name (face-background 'default) 10))
                                    ('dark
                                     (color-lighten-name (face-background 'default) 5)))
                      )
  (set-face-attribute 'bold nil
                      :weight 'bold
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light "black")
                                    ('dark "white"))
                      )
  (set-face-attribute 'bold-italic nil
                      :weight 'bold :slant 'italic
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light "black")
                                    ('dark "white"))
                      )
  (set-face-attribute 'underline nil
                      :foreground (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light "black")
                                    ('dark "white"))
                      :background (cl-case (alist-get 'background-mode (frame-parameters))
                                    ('light
                                     (color-darken-name (face-background 'default) 10))
                                    ('dark
                                     (color-lighten-name (face-background 'default) 5)))
                      )
  )
(add-hook 'circadian-after-load-theme-hook #'circadian:builtin-faces)


(provide 'init-emacs-theme)

;;; init-emacs-theme.el ends here
