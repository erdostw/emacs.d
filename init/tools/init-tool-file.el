;;; init-tool-file.el --- init for Files Handling
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ pandoc ] -- pandoc interface.

;; (use-package pandoc
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq pandoc-turn-on-advice-eww t)
;;   )

;;; [ pandoc-mode ] -- pandoc-mode is an Emacs mode for interacting with Pandoc.

;; (use-package pandoc-mode
;;   :ensure t
;;   :init
;;   (add-hook 'markdown-mode-hook 'pandoc-mode)
;;   ;; turn on pandoc-mode if a pandoc settings file exists.
;;   ;; (add-hook 'markdown-mode-hook 'conditionally-turn-on-pandoc)
;;   :config  
;;   (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
;;   )


(provide 'init-tool-file)

;;; init-tool-file.el ends here
