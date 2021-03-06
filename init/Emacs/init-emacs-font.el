;;; init-emacs-font.el --- init for Emacs font settings -*- lexical-binding: t; -*-

;;; Time-stamp: <2020-12-10 16:50:30 stardiviner>

;;; Commentary:

;; the value is in 1/10pt, so 100 will give you 10pt, etc
;;
;; - [C-u C-x =]
;; - [M-x describe-font]
;; - [M-x describe-fontset]
;; - from command: $ fc-list
;;
;; Emacs set font functions:
;;
;; - `set-face-attribute'
;; - `set-frame-font'
;;
;; - "DejaVu Sans Mono"
;; - "Hack"
;; - "Fira Sans"
;; - "Sarasa Mono SC"
;; - "Sarasa Nerd"
;; - "Noto Sans CJK SC"
;; - "Noto Sans Mono CJK SC"

;;; Code:

;;; [ set font for Emacs ]

;; (cond
;;  ((x-list-fonts "DejaVu Sans Mono")
;;   (set-face-attribute 'default nil
;;                       :family "DejaVu Sans Mono")))


;; (set-fontset-font nil 'unicode
;;                   (font-spec :name "Symbola") nil 'append)

;;; [ display Unicode Emoji ]
;;; A font that supports emoji is needed. The best results are obtained with
;;; "Noto Color Emoji" or "Symbola". It might be necessary to instruct Emacs to
;;; use such font with a line like the following.
(set-fontset-font t 'symbol
                  (font-spec :family "Noto Color Emoji") nil 'prepend)

(dolist (charset '(greek
                   ;; symbol
                   ))
  (set-fontset-font nil charset
                    (font-spec :name "Symbola") nil 'prepend))

(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "Source Han Sans CN") nil 'append))

;;; setting default font based on my preferred priority.
(defvar font-prefered-fonts
  '("DejaVu Sans Mono" "Noto Sans Mono" "Fira Code" "SF Mono" "Source Code Pro" "Hack"
    "Menlo" "Monaco" "Consolas"))

(defun font-available-p (font)
  "Detect font available?"
  (if (stringp font)
      (member font (font-family-list))
    (warn "Argument FONT should be string!")))

(if (eq system-type 'windows-nt)
    (add-to-list 'font-prefered-fonts "Sarasa Mono SC"))

(cl-loop for font in font-prefered-fonts
         when (font-available-p font)
         return (set-face-attribute 'default nil :family font))



(provide 'init-emacs-font)

;;; init-emacs-font.el ends here
