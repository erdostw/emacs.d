;;; init-my-prog-lang-D.el --- init for D programming language.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------
;;; [ d-mode ] -- major mode for editing D code.

(use-package d-mode
  :ensure t
  :config
  (autoload 'd-mode "d-mode" "Major mode for editing D code." t)
  (add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))
  )


;;; ----------------------------------------------------------------------------

(provide 'init-my-prog-lang-D)

;;; init-my-prog-lang-D.el ends here
