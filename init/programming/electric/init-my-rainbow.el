;;; init-my-rainbow.el --- 
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ rainbow-delimiters ] -- rainbow color parenthesis

(require 'rainbow-delimiters nil 'noerror)
;; (when (require 'rainbow-delimiters nil 'noerror)
;;   )

(eval-after-load 'rainbow-delimiters
  (lambda ()
    (rainbow-delimiters-mode t)
    ;; 1. global
    ;; (global-rainbow-delimiters-mode)
    ;; 2. enable in all Lisp dialects modes
    ;; (add-hook 'lisp-dialects-mode-hook 'rainbow-delimiters-mode)
    (hook-modes lisp-dialects-mode (rainbow-delimiters-mode-enable))
    ;; 3.. enable in all programming-related modes
    ;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    ;; 4. enable in specific modes
    (dolist (hook '(ruby-mode-hook
                    enh-ruby-mode-hook
                    ))
      (add-hook hook 'rainbow-delimiters-mode-enable))
    ))

;; you have two styles:
;; 1. :box t
;; 2. :inverse-video t
;; 3. :weight 'bold
(set-face-attribute 'rainbow-delimiters-depth-1-face nil
                    :foreground "#2aa198"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-2-face nil
                    :foreground "#b58900"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-3-face nil
                    :foreground "#268bd2"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-4-face nil
                    :foreground "#dc322f"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-5-face nil
                    :foreground "#859900"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-6-face nil
                    :foreground "#268bd2"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-7-face nil
                    :foreground "#cb4b16"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-8-face nil
                    :foreground "#d33682"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-depth-9-face nil
                    :foreground "#839496"
                    :weight 'bold)
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                    :foreground "orange" :background "black"
                    )
(set-face-attribute 'rainbow-delimiters-mismatched-face nil
                    :foreground "red" :background "black"
                    )


;;; rainbow-identifiers

;; (require 'rainbow-identifiers)

;; (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)


;;; rainbow-block

;; (require 'rainbow-blocks)

;; (add-hook 'clojure-mode-hook 'rainbow-blocks-mode)


(provide 'init-my-rainbow)

;;; init-my-rainbow.el ends here
