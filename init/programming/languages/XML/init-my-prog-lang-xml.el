;;; init-my-prog-lang-xml.el --- init XML programming language
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ nxml-mode ]

(require 'nxml-mode)

(push '("<\\?xml" . nxml-mode) magic-mode-alist)

;; pom files should be treated as xml files
(add-to-list 'auto-mode-alist '("\\.pom\\'" . nxml-mode))

(setq nxml-child-indent 2
      nxml-attribute-indent 2
      nxml-auto-insert-xml-declaration-flag nil
      )

;;; XML completion
(setq nxml-bind-meta-tab-to-complete-flag t ; M-Tab to complete
      nxml-slash-auto-complete-flag nil ; </ to complete
      )
;; company-nxml
(add-hook 'nxml-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-nxml)))


;;; [ auto-complete-nxml ]

(use-package auto-complete-nxml
  ;; :ensure t
  :config
  ;; If you want to start completion manually from the beginning
  (setq auto-complete-nxml-automatic-p nil)
  
  ;; Keystroke for popup help about something at point.
  (setq auto-complete-nxml-popup-help-key "M-h")
  
  ;; Keystroke for toggle on/off automatic completion.
  ;; (setq auto-complete-nxml-toggle-automatic-key "C-c C-t")
  )



(provide 'init-my-prog-lang-xml)

;;; init-my-prog-lang-xml.el ends here
