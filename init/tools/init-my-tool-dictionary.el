;;; init-my-tool-dictionary.el --- init my Emacs dictionary.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ sdcv.el ]

(use-package pos-tip
  :ensure t)

(load "~/.emacs.d/init/extensions/sdcv.el")

(setq sdcv-dictionary-simple-list ;; a simple dictionary list for popup display
      '(;; "WordNet"
        "牛津英汉双解美化版"
        ))

(setq sdcv-dictionary-complete-list ;; a complete dictionary list for buffer display
      '("WordNet"
        "牛津英汉双解美化版"
        "朗道英汉字典5.0"
        "朗道汉英字典5.0"
        ))

(define-key sdcv-mode-map (kbd "n") 'sdcv-next-dictionary)
(define-key sdcv-mode-map (kbd "p") 'sdcv-previous-dictionary)
(define-key sdcv-mode-map (kbd "I") 'sdcv-search-input)
(define-key sdcv-mode-map (kbd "i") 'sdcv-search-input+)
(define-key sdcv-mode-map (kbd "Q") 'sdcv-search-pointer)
(define-key sdcv-mode-map (kbd "q") 'sdcv-search-pointer+)
(define-key sdcv-mode-map (kbd "V") 'show-entry)
(define-key sdcv-mode-map (kbd "v") 'hide-entry)

(unless (boundp 'dictionary-map)
  (define-prefix-command 'dictionary-map))
(define-key my-tools-prefix (kbd "d") 'dictionary-map)

(define-key dictionary-map (kbd "d") 'sdcv-search-pointer+)
(define-key dictionary-map (kbd "C-d") 'sdcv-search-input)


;;; [ babel ] -- An Emacs interface to different translation services available on the Internet.

;; (autoload 'babel "babel"
;;   "Use a web translation service to translate the message MSG." t)
;; (autoload 'babel-region "babel"
;;   "Use a web translation service to translate the current region." t)
;; (autoload 'babel-as-string "babel"
;;   "Use a web translation service to translate MSG, returning a string." t)
;; (autoload 'babel-buffer "babel"
;;   "Use a web translation service to translate the current buffer." t)
;;
;; (setq babel-preferred-from-language "English"
;;       babel-preferred-to-language "Chinese"
;;       babel-remember-window-configuration t
;;       babel-max-window-height 30
;;       babel-echo-area t
;;       babel-select-output-window t
;;       )



;; (defun my-translate-dwim (func-region func-string func-buffer)
;;   "My custom function to use translate functions depend on situations."
;;   (interactive)
;;
;;   (defalias-maybe 'translate-dwim-region func-region)
;;   (defalias-maybe 'translate-dwim-string func-string)
;;   (defalias-maybe 'translate-dwim-buffer func-buffer)
;;  
;;   ;; region
;;   (if (region-active-p)
;;       (translate-dwim-region (region-content)))
;;   (if (yes-or-no-p "buffer(n) / interactive input (y)")
;;       ;; interactive input
;;       (let ((msg (read-string "Translate phrase: ")))
;;         (translate-dwim-string msg))
;;     ;; buffer
;;     (translate-dwim-buffer)
;;     )
;;   )
;;
;; (define-key dictionary-map (kbd "t")
;;   (lambda ()
;;     (interactive)
;;     (my-translate-dwim 'babel-region 'babel-as-string 'babel-buffer)))


;;; [ synonymous ] -- a thesaurus client that replace with synonym or antonym.

;; (use-package synonymous)


;;; [ Goldendict ]

(defun goldendict-dwim ()
  "Query current symbol/word at point with Goldendict."
  (interactive)
  (save-excursion
    ;;; way: get word with `thing-at-point'
    (let ((word (if (region-active-p)
                    (buffer-substring-no-properties (mark) (point))
                  (thing-at-point 'word))))
      ;; pass the selection to Emacs shell command goldendict.
      ;; use Goldendict API: "Scan Popup"
      (shell-command (concat "goldendict " word)))
    )
  )

(define-key dictionary-map (kbd "d") 'goldendict-dwim)


;;; [ google-translate ]

(use-package google-translate
  :ensure t
  :init
  ;; (require 'google-translate)
  ;; (require 'google-translate-default-ui)
  :config
  (setq google-translate-enable-ido-completion nil
        google-translate-show-phonetic t
        ;; google-translate-listen-program
        google-translate-output-destination nil ; 'echo-area, 'popup
        google-translate-pop-up-buffer-set-focus nil
        )

  (set-face-attribute 'google-translate-phonetic-face nil
                      :background "orange" :foreground "black"
                      :slant 'italic)
  (set-face-attribute 'google-translate-listen-button-face nil
                      :background "gray" :foreground "black"
                      :weight 'bold)
  ;; (set-face-attribute 'google-translate-suggestion-face nil
  ;;                     )
  ;; (set-face-attribute 'google-translate-suggestion-label-face nil
  ;;                     )
  (set-face-attribute 'google-translate-translation-face nil
                      :height 1.4
                      )

  (define-key dictionary-map (kbd "t") 'google-translate-smooth-translate)
  ;; (define-key dictionary-map (kbd "T") 'google-translate-at-point)
  ;; (define-key dictionary-map (kbd "C-t") 'google-translate-query-translate)
  )


(provide 'init-my-tool-dictionary)

;;; init-my-tool-dictionary.el ends here
