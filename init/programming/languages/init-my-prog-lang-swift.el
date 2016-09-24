;;; init-my-prog-lang-swift.el --- init for Swift
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ swift-mode ]

;;; Usage:
;;
;; - [C-c C-z] `swift-mode-run-repl' :: run REPL.
;; - [C-c C-r] `swift-mode-send-region' :: send region to REPL.
;; - [C-c C-f] `swift-mode-send-buffer' :: send buffer to REPL.

(use-package swift-mode
  :ensure t
  :config
  (setq swift-indent-offset 4
        swift-indent-switch-case-offset 2
        swift-indent-multiline-statement-offset 2
        swift-indent-hanging-comma-offset nil)
  (setq swift-repl-executable "swift")
  ;; flycheck + swift-mode
  (add-to-list 'flycheck-checkers 'swift)
  ;; Swift flycheck is disabled by default because not available under Linux.
  (setq flycheck-swift-sdk-path "")
  )


;;; [ swift3-mode ] -- major-mode for Apple's Swift programming language.

(use-package swift3-mode
  :ensure t)


;;; [ company-sourcekit ]

(use-package company-sourcekit
  :ensure t
  :config
  (setq company-sourcekit-use-yasnippet t
        company-sourcekit-verbose nil
        ;; sourcekit-sourcekitdaemon-executable
        )
  (add-hook 'swift-mode-hook
            (lambda ()
              (my-company-add-backend-locally 'company-sourcekit)
              ))
  )


;;; [ flycheck-swift ] -- Flycheck extension for Apple's Swift.

;; (use-package flycheck-swift
;;   :ensure t)


;;; [ ob-swift ]

(use-package ob-swift
  :ensure t
  )


(provide 'init-my-prog-lang-swift)

;;; init-my-prog-lang-swift.el ends here
