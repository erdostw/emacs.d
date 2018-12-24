;;; init-prog-lang-HDL.el --- init for HDL
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ vhdl-mode ]

(use-package vhdl-mode
  :ensure t
  :init
  (autoload 'vhdl-mode "vhdl-mode" "VHDL Mode" t)
  (push '("\\.vhdl?\\'" . vhdl-mode) auto-mode-alist)
  )


;;; [ vhdl-capf ]

(use-package vhdl-capf
  :ensure t
  :config
  (vhdl-capf-enable)
  )


;;; [ vhdl-tools ]

(use-package vhdl-tools
  :ensure t
  :init
  (add-hook 'vhdl-mode-hook
            (lambda ()
              (vhdl-tools-mode 1)))
  )


(provide 'init-prog-lang-HDL)

;;; init-prog-lang-HDL.el ends here