;;; init-my-emacs-search-find.el --- init for command find
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ find-file-in-project ]

(use-package find-file-in-project
  :ensure t
  :config
  (global-set-key (kbd "C-x f") 'find-file-in-project-by-selected)
  )


;;; [ f3 ]

(use-package f3
  :ensure t
  :config
  (global-set-key (kbd "C-x f") 'f3))


(provide 'init-my-emacs-search-find)

;;; init-my-emacs-search-find.el ends here
