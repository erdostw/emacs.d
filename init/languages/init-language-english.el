;;; init-language-english.el --- init for English Language.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ capitalized-words-mode ]

;; (capitalized-words-mode 1)

;;; [ electric punctuation ]

;;; [ stem-english ] -- routines for Stemming English word (Emacs)

(use-package stem-english
  :ensure t
  :defer t)


(provide 'init-language-english)

;;; init-language-english.el ends here
