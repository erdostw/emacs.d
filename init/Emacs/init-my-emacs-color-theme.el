;;; init-my-emacs-color-theme.el --- init for color theme
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Color Theme ]

;; Usage:
;; - [M-x customize-face] -- to custom current point face color/style.
;; - [M-x list-colors-display] / [helm-colors]/[C-x c c] -- list out all basic colors.
;; - [C-u M-x list-faces-display RET org] -- overview of all the faces in org-mode.
;; - [M-x customize-group org-font-lock] -- custom org-faces and other aspects of org-apperance.
;; - [C-u C-x =] -- verbose information about the properties of the text under the point.
;; - [M-x load-theme RET (theme)] -- load a color-theme.

(require 'color) ; for function `color-darken-name'

;;; initialize color-theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)))
(setq color-theme-is-global t
      color-theme-is-cumulative t)

;; load theme way
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/")

;; (load-theme 'solarized-dark t)


;;; [ doom-theme ] -- Emacs themes inspired by Atom One, for Emacs 24.4+.

(use-package doom-themes
  :ensure t
  :config
  (setq doom-enable-bold t
        doom-enable-italic t)
  
  ;; themes: 'doom-one, 'doom-dark, 'doom-one-light, 'doom-tron, 'doom-peacock
  (load-theme 'doom-one t)
  
  (add-hook 'find-file-hook 'doom-buffer-mode) ; brighter source buffers.
  (add-hook 'minibuffer-setup-hook 'doom-buffer-mode) ; brighter minibuffer when active
  ;; (require 'doom-neotree) ; for neotree
  )


;;; custom faces

(set-face-attribute 'font-lock-function-name-face nil
                    :background (color-lighten-name (face-background 'default) 2)
                    )
(set-face-attribute 'font-lock-type-face nil
                    :background (color-lighten-name (face-background 'default) 3)
                    :foreground "green")

;; italic & bold
(set-face-attribute 'italic nil
                    :slant 'italic
                    :foreground "#eeeeee"
                    :weight 'normal
                    :height 100
                    :underline nil)
(set-face-attribute 'bold nil
                    :weight 'bold
                    :foreground "#c3c3c3")
(set-face-attribute 'bold-italic nil
                    :foreground "pink")
(set-face-attribute 'underline nil
                    :underline "dark gray")
;; region
(set-face-attribute 'region nil
                    :inverse-video nil
                    ;; "dark green", "forest green", "khaki",
                    :background "khaki"
                    ;; :background (color-darken-name (face-background 'default) 10)
                    )
;; highlight
(set-face-attribute 'highlight nil
                    :background (color-darken-name (face-background 'default) 5)
                    )

;; comment
;; family: DejaVu Serif,  Droid Serif, Gabriola, Gentium, GFS Didot, Latin Modern Mono, Segoe Print,
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic
                    )
;; built-in function.
(set-face-attribute 'font-lock-builtin-face nil
                    :slant 'italic)


;;; [ select-themes ] -- select color-theme with completing-read.

(use-package select-themes
  :ensure t
  :defer t)

;;; set color-theme for `emacsclient'

(if (server-running-p) ; (daemonp)
    (add-hook 'after-make-frame-functions
              '(lambda (frame)
                 (with-selected-frame frame
                   (progn
                     (toggle-frame-maximized)
                     (load-theme 'doom-one t)
                     )))))


(provide 'init-my-emacs-color-theme)

;;; init-my-emacs-color-theme.el ends here
