;;; init-prog-build.el --- init for programming source code building status.

;;; Commentary:



;;; Code:

;;; [ build-status ] -- mode line build status indicator.

(use-package build-status
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'build-status-mode)
  )


(provide 'init-prog-build)

;;; init-prog-build.el ends here