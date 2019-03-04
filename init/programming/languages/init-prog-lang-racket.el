;;; init-prog-lang-racket.el --- init for Racket

;;; Time-stamp: <2019-02-27 15:37:17 stardiviner>

;;; Commentary:



;;; Code:

;;; [ racket-mode ] -- Major mode for Racket language.

(use-package racket-mode
  :ensure t
  :mode (("\\.rkt\\'" . racket-mode)))

;;; [ ob-racket ]

(use-package ob-racket
  :quelpa (ob-racket :fetcher github :repo "DEADB17/ob-racket")
  :config
  (add-to-list 'org-babel-load-languages '(racket . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("racket" . "rkt")))



(provide 'init-prog-lang-racket)

;;; init-prog-lang-racket.el ends here
