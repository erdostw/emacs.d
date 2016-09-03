;;; init-my-emacs-prettify.el --- init for prettify Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ pretty-mode ] -- redisplay parts of the Emacs buffer as pretty symbols.

(use-package pretty-mode
  :ensure t
  :config
  (add-to-list 'pretty-supported-modes 'ruby-mode)
  (add-to-list 'pretty-supported-modes 'enh-ruby-mode)

  ;; (add-to-list 'pretty-default-groups '(:function))
  ;; (add-to-list 'pretty-active-groups '(ruby-mode :function))
  ;; (add-to-list 'pretty-active-patterns '(ruby-mode))
  ;; (add-to-list 'pretty-patterns '((ruby-mode ("->" . ?λ))))

  ;; 1. if you want to set it globally
  ;; (global-pretty-mode t)
  ;; 2. if you want to set it only for a specific mode
  ;; (dolist (hook '(prog-mode-hook
  ;;                 ))
  ;;   (add-hook hook 'turn-on-pretty-mode))
  )


;;; [ pretty-symbols ]

(use-package pretty-symbols
  :ensure t
  :config
  (setq prettify-symbols-unprettify-at-point 'right-edge)
  
  ;; (setq pretty-symbol-categories '(lambda relational logical)
  ;;       ;; pretty-symbol-patterns '()
  ;;       )

  (global-prettify-symbols-mode 1)

  ;; only prettify lambda in Lisp dialects with two spaces without breaking
  ;; indentation.

  ;; [ Lisp / Clojure ]
  ;; prettify with symbols
  ;; (defvar my/clojure-prettify-alist '())
  ;;
  ;; (add-to-list 'my/clojure-prettify-alist
  ;;              '("<=" . (?· (Br . Bl) ?≤)))
  ;; (add-to-list 'my/clojure-prettify-alist
  ;;              '(">=" . (?· (Br . Bl) ?≥)))
  ;; (add-to-list 'my/clojure-prettify-alist
  ;;              '("->" .  (?\s (Br . Bl) ?\s (Bc . Bc) ?⇨)))
  ;; (add-to-list 'my/clojure-prettify-alist
  ;;              '("->>" . (?\s (Br . Bl) ?\s (Br . Bl) ?\s
  ;;                             (Bc . Br) ?⇨ (Bc . Bl) ?⇨)))
  ;;
  ;; (with-eval-after-load 'clojure-mode
  ;;   (setq clojure--prettify-symbols-alist
  ;;         (append my/clojure-prettify-alist
  ;;                 clojure--prettify-symbols-alist)))
  ;; (with-eval-after-load 'lisp-mode
  ;;   (setq lisp-prettify-symbols-alist
  ;;         (append my/clojure-prettify-alist
  ;;                 lisp-prettify-symbols-alist)))
  )


;;; [ page-break-lines-mode ] --- page breaks (^L characters) are displayed as a horizontal line of a character.

;;; In Page Break mode, page breaks (^L characters) are displayed as a horizontal line of `page-break-string-char' characters.

(use-package page-break-lines
  :ensure t
  :config
  (setq page-break-lines-char ?─)
  (global-page-break-lines-mode t)
  )


;;; [ digit-groups ] -- highlight place-value positions in numbers.

(use-package digit-groups
  :ensure t
  :config
  (set-face-attribute 'digit-groups-default-face nil
                      :foreground "light gray")

  ;; (add-hook 'org-mode-hook #'digit-groups-mode)
  )


(provide 'init-my-emacs-prettify)

;;; init-my-emacs-prettify.el ends here
