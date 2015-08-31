;;; init-my-emacs-image.el --- init for Image display
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ auto-image-file-mode ]

;; (setq image-file-name-extensions '("png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm" "pnm" "svg"))

(auto-image-file-mode t) ;; auto display image


;;; [ iimage-mode ]

(if (not (featurep 'iimage))
    (require 'iimage))

;;; for eshell,
;; auto display image in eshell for links after command `cat'.
;; https://emacs.stackexchange.com/questions/3432/display-images-in-eshell-with-iimage-mode

(add-hook 'eshell-mode-hook 'iimage-mode) ; enable iimage-mode in eshell.

(defun my/iimage-mode-refresh--eshell/cat (orig-fun &rest args)
  "Display image when using cat on it."
  (let ((image-path (cons default-directory iimage-mode-image-search-path)))
    (dolist (arg args)
      (let ((imagep nil)
            file)
        (with-silent-modifications
          (save-excursion
            (dolist (pair iimage-mode-image-regex-alist)
              (when (and (not imagep)
                       (string-match (car pair) arg)
                       (setq file (match-string (cdr pair) arg))
                       (setq file (locate-file file image-path)))
                (setq imagep t)
                (add-text-properties 0 (length arg)
                                     `(display ,(create-image file)
                                               modification-hooks
                                               (iimage-modification-hook))
                                     arg)
                (eshell-buffered-print arg)
                (eshell-flush)))))
        (when (not imagep)
          (apply orig-fun (list arg)))))
    (eshell-flush)))

(advice-add 'eshell/cat :around #'my/iimage-mode-refresh--eshell/cat)



(provide 'init-my-emacs-image)

;;; init-my-emacs-image.el ends here
