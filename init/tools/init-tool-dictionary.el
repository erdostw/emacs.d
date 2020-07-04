;;; init-tool-dictionary.el --- init my Emacs dictionary.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(unless (boundp 'dictionary-prefix)
  (define-prefix-command 'dictionary-prefix))
(define-key tools-prefix (kbd "d") 'dictionary-prefix)

;;; [ Goldendict ]

(use-package goldendict
  :ensure t
  :commands (goldendict-dwim)
  :bind (:map dictionary-prefix ("d" . goldendict-dwim)))

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
           (google-translate-default-source-language "en") ; "auto", "en"
           (google-translate-default-target-language "zh-CN") ; `google-translate-supported-languages'
           (google-translate-translation-directions-alist '(("en" . "zh-CN")
                                                            ("zh-CN" . "en")
                                                            ("zh-CN" . "ja")
                                                            ("zh-CN" . "ko"))) ; for `google-translate-smooth-translate' + [C-n/p]
           (google-translate-listen-program (executable-find "mpv"))
           (google-translate-pop-up-buffer-set-focus t)
           (google-translate-result-to-kill-ring t))
  :init
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
  
  :config
  (add-to-list 'display-buffer-alist
               '("^\\*Google Translate\\*"
                 (display-buffer-reuse-window display-buffer-below-selected)))
  
  ;; enable proxy for translate.google.com
  ;; (add-to-list 'url-proxy-services '("no_proxy" . "^.*(?!translate\\.google\\.com).*$"))
  )

;;; [ ob-translate ] -- allows you to translate blocks of text within org-mode.

(use-package ob-translate
  :ensure t
  :defer t
  :commands (org-babel-execute:translate)
  :config
  (add-to-list 'org-babel-load-languages '(translate . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  ;; add translate special block into structure template alist.
  (add-to-list 'org-structure-template-alist '("t" . "src translate"))
  (defun ob-translate-toggle-proxy (origin-func body params)
    (call-interactively 'proxy-mode-enable)
    (let ((output (funcall origin-func body params)))
      (call-interactively 'proxy-mode-disable)
      output))
  (advice-add 'org-babel-execute:translate :around #'ob-translate-toggle-proxy))

;;; [ baidu-translate ] -- A emacs plugin using baidu-translate-api.

(use-package baidu-translate
  :ensure t
  :defer t
  :commands (baidu-translate-zh-mark baidu-translate-zh-whole-buffer)
  :config
  (setq baidu-translate-appid
        (my/json-read-value my/account-file 'baidu-translate-appid)
        baidu-translate-security
        (my/json-read-value my/account-file 'baidu-translate-security))
  (add-to-list 'display-buffer-alist
               '("^\\*baidu-translate\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected))))


(provide 'init-tool-dictionary)

;;; init-tool-dictionary.el ends here
