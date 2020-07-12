;;; init-tool-downloader.el --- init for Downloader
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ download-region ] -- simple in-buffer download manager for Emacs.

(use-package download-region
  :ensure t
  :commands (download-region-as-url))

;;; [ youtube-dl ] -- A youtube-dl download manager for Emacs.

(use-package youtube-dl
  :load-path "~/Code/Emacs/youtube-dl/"
  :defer t
  :commands (youtube-dl youtube-dl-list)
  :custom (youtube-dl-directory "~/Downloads/")
  :config
  (add-to-list 'display-buffer-alist
               '("^\\*youtube-dl list\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected))))


(provide 'init-tool-downloader)

;;; init-tool-downloader.el ends here
