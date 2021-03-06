;;; init-prog-lang-reStructuredText.el --- init for reStructuredText
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ rst ] -- Mode for viewing and editing reStructuredText-documents.

(use-package rst
  :commands (rst-mode)
  :config (add-hook 'rst-adjust-hook 'rst-toc-update))

;;; [ auto-complete-rst ] -- auto-complete extension for ReST and Sphinx.

(use-package auto-complete-rst
  :ensure t
  :defer t
  :mode ("\\.rst\'")
  :hook (rst-mode . auto-complete-mode)
  :init (setq auto-complete-rst-other-sources
              '(ac-source-filename
                ac-source-abbrev
                ac-source-dictionary
                ac-source-yasnippet))
  :config (auto-complete-rst-init))

;;; [ ox-rst ] -- reStructuredText export backend for Org-mode.

(use-package ox-rst
  :ensure t
  :defer t)

;;; [ sphinx-mode ] -- minor mode providing sphinx support.

;; (use-package sphinx-mode
;;   :ensure t
;;   :defer t
;;   :init (add-hook 'rst-mode-hook 'sphinx-mode))

;;; [ sphinx-frontend ] -- Launch build process for rst documents via sphinx.

;; (use-package sphinx-frontend
;;   :ensure t
;;   :defer t)


(provide 'init-prog-lang-reStructuredText)

;;; init-prog-lang-reStructuredText.el ends here
