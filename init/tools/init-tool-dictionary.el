;;; init-tool-dictionary.el --- init my Emacs dictionary.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'dictionary-prefix)
  (define-prefix-command 'dictionary-prefix))
(define-key tools-prefix (kbd "d") 'dictionary-prefix)

;;; [ Goldendict ] -- Query word smartly with Goldendict.

(use-package goldendict
  :ensure t
  :commands (goldendict-dwim)
  :bind (:map dictionary-prefix ("d" . goldendict-dwim)))

;;; [ multi-translate ] -- Translate word or region at point with multiple translation services.

;; (use-package multi-translate
;;   ;; :ensure t
;;   :quelpa (multi-translate :fetcher github :repo "twlz0ne/multi-translate.el")
;;   :commands (multi-translate multi-translate-at-point multi-translate-amend-query)
;;   :bind (:map dictionary-prefix ("m" . multi-translate-at-point))
;;   :init (add-to-list 'display-buffer-alist '("^\\*Multi Translate\\*" . (display-buffer-below-selected)))
;;   :config (define-key multi-translate-mode-map (kbd "q") 'delete-window))

;;; [ google-translate ] -- Emacs interface to Google Translate.

(use-package google-translate
  :ensure t
  :defer t
  :bind (:map dictionary-prefix
              ("t" . google-translate-smooth-translate)
              ("C-t" . google-translate-at-point)
              ("M-t" . google-translate-query-translate)
              ("C-r" . google-translate-at-point-reverse)
              ("M-r" . google-translate-query-translate-reverse)
              ("C-b" . google-translate-buffer)
              ("C-p" . google-translate-paragraphs-overlay)
              ("M-p" . google-translate-paragraphs-insert))
  :custom ((google-translate-base-url "https://translate.google.cn/translate_a/single")
           (google-translate-listen-url "https://translate.google.cn/translate_tts")
           (google-translate--tkk-url "https://translate.google.cn/")
           (google-translate-show-phonetic t)
           (google-translate-pop-up-buffer-set-focus t)
           (google-translate-default-source-language "auto") ; "auto", "en"
           ;; (google-translate-default-target-language "zh-CN") ; `google-translate-supported-languages'
           (google-translate-translation-directions-alist '(("en" . "zh-CN")
                                                            ("zh-CN" . "en")
                                                            ("zh-CN" . "ja")
                                                            ("zh-CN" . "ko"))) ; for `google-translate-smooth-translate' + [C-n/p]
           (google-translate-listen-program (executable-find "mpv"))
           (google-translate-pop-up-buffer-set-focus t)
           (google-translate-result-to-kill-ring t))
  :init (add-to-list 'display-buffer-alist '("^\\*Google Translate\\*" . (display-buffer-below-selected)))
  ;; translate web page URL link.
  (defun google-translate-webpage (url)
    "Translate web page URL and open in web browser."
    (interactive (list (read-from-minibuffer
                        "URL: "
                        (or (thing-at-point 'url)
                            (funcall interprogram-paste-function)))))
    (browse-url
     (format "http://translate.google.com/translate?js=n&sl=auto&tl=zh-CN&u=%s" url)))
  
  (define-key dictionary-prefix (kbd "u") 'google-translate-webpage)
  
  ;; support `google-translate' in `pdf-view-mode' buffer.
  (defun my/google-translate-mark-pdf-view-page (orig-func &rest args)
    (interactive)
    (let ((buffer (current-buffer)))
      (when (eq major-mode 'pdf-view-mode)
        (pdf-view-mark-whole-page))
      (apply orig-func args)
      (with-current-buffer buffer
        (deactivate-mark))))
  (advice-add 'google-translate-at-point :around #'my/google-translate-mark-pdf-view-page)
  
  ;; enable proxy for translate.google.com
  ;; (add-to-list 'url-proxy-services '("no_proxy" . "^.*(?!translate\\.google\\.com).*$"))
  )

;;; [ ob-translate ] -- allows you to translate blocks of text within org-mode.

(use-package ob-translate
  ;; :ensure t
  ;; :quelpa (ob-translate :fetcher github :repo "stardiviner/ob-translate" :branch "develop")
  :load-path "~/Code/Emacs/ob-translate"
  :defer t
  :commands (org-babel-execute:translate)
  :init
  ;; add translate special block into structure template alist.
  (with-eval-after-load 'org
    (add-to-list 'org-structure-template-alist '("t" . "translate")))
  :config
  (add-to-list 'org-babel-load-languages '(translate . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

;;; [ go-translate ] -- Improved Google Translate interface with asynchronous request and better user experience.

;; (use-package go-translate
;;   :ensure t
;;   :custom ((go-translate-base-url "https://translate.google.cn/")
;;            (go-translate-local-language "en")
;;            (go-translate-target-language "zh-CN")
;;            (go-translate-buffer-follow-p t)
;;            (go-translate-buffer-source-fold-p t)
;;            (go-translate-buffer-window-config
;;             '((display-buffer-reuse-window display-buffer-below-selected))))
;;   :commands (go-translate go-translate-popup))

;;; [ baidu-translate ] -- A emacs plugin using baidu-translate-api.

;; (use-package baidu-translate
;;   :ensure t
;;   :defer t
;;   :custom ((baidu-translate-appid (my/json-read-value my/account-file 'baidu-translate-appid))
;;            (baidu-translate-security (my/json-read-value my/account-file 'baidu-translate-security)))
;;   :commands (baidu-translate-zh-mark baidu-translate-zh-whole-buffer)
;;   :init (add-to-list 'display-buffer-alist '("^\\*baidu-translate\\*" . (display-buffer-below-selected))))

;;; [ org-translate ] -- Org-based translation environment.

(use-package org-translate
  :ensure t
  :defer t
  :commands (org-translate-mode))

;;; [ english-teacher ] -- translate sentence following point.

;; (use-package english-teacher
;;   :load-path "~/Code/Emacs/english-teacher"
;;   :commands (english-teacher-smart-translate)
;;   :hook ((Info-mode Man-mode Woman-Mode elfeed-show-mode eww-mode) . english-teacher-follow-mode))


(provide 'init-tool-dictionary)

;;; init-tool-dictionary.el ends here
