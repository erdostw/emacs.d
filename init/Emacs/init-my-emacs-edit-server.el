;;; init-my-emacs-edit-server.el --- init for Emacs Edit Server
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------
;;;_ [ edit-server ]

;; A Chrome "clone" of It's All Text for spawning an editor to edit text areas in browsers with Emacs.
;; https://github.com/stsquad/emacs_chrome

(use-package edit-server
  :ensure t
  :if window-system
  :defer t
  :init
  (edit-server-start)
  
  :config
  (setq edit-server-new-frame t)
  (setq edit-server-url-major-mode-alist
        '(("github\\.com" . markdown-mode)
          ;; Stack Overflow
          ("stackoverflow\\.com" . markdown-mode)
          ("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt" . markdown-mode)
          (".*\\.stackexchange\\.com/.*" . markdown-mode)
          ("segmentfault\\.com" . markdown-mode)
          ;; Jupyter notebooks
          ;; localhost:8888/notebooks/Untitled1.ipynb?kernel_name=clojure
          ("localhost:8888/notebooks/.*\\.ipynb\\?kernel_name=clojure" . clojure-mode)
          ("localhost:8888/notebooks/.*\\.ipynb\\?kernel_name=ruby" . ruby-mode)
          ("localhost:8888/notebooks/.*\\.ipynb\\?kernel_name=julia" . julia-mode)
          ("localhost:8888/notebooks/.*\\.ipynb\\?kernel_name=python" . python-mode)
          ))
  )

;;; [ atomic-chrome ] -- with websocket improvement on `edit-server'.

(use-package atomic-chrome
  :ensure t
  :config
  (atomic-chrome-start-server)
  )


;;; ----------------------------------------------------------------------------

(provide 'init-my-emacs-edit-server)

;;; init-my-emacs-edit-server.el ends here
