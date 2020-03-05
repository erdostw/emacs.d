;;; init-microsoft-windows.el --- init for Microsoft Windows.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------
;;; [ ini-mode ] -- Major mode for Windows-style .ini files.

(use-package ini-mode
  :ensure t
  :mode "\\.ini\\'")

;;; [ Batch Script ]

(require 'init-bat)

;;; [ PowerShell ]

(require 'init-powershell)

;;; [ AutoHotkey ]

(use-package ahk-mode
  :ensure t
  :defer t)

;;; ----------------------------------------------------------------------------

(provide 'init-microsoft-windows)

;;; init-microsoft-windows.el ends here
