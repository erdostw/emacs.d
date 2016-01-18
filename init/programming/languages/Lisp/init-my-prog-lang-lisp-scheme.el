;;; init-my-prog-lang-lisp-scheme.el --- init for Scheme
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Scheme Mode ]


;;; [ Inferior Scheme ]

;;; Usage:
;; (run-scheme)

;; (setq scheme-program-name "scheme")


;;; [ Geiser ] -- Geiser is a collection of Emacs major and minor modes that conspire with one or more Scheme interpreters to keep the Lisp Machine Spirit alive.

;;; Geiser is a collection of Emacs major and minor modes that conspire with one
;;; or more Scheme interpreters to keep the Lisp Machine Spirit alive. It draws
;;; inspiration (and a bit more) from environments such as Common Lisp’s Slime,
;;; Factor’s FUEL, Squeak or Emacs itself, and does its best to make Scheme
;;; hacking inside Emacs (even more) fun.

;;; Or, to be precise, what i consider fun. Geiser is thus my humble
;;; contribution to the dynamic school of expression, and a reaction against
;;; what i perceive as a derailment, in modern times, of standard Scheme towards
;;; the static camp. Because i prefer growing and healing to poking at corpses,
;;; the continuously running Scheme interpreter takes the center of the stage in
;;; Geiser. A bundle of Elisp shims orchestrates the dialog between the Scheme
;;; interpreter, Emacs and, ultimately, the schemer, giving her access to live
;;; metadata. Here’s how.

(use-package geiser
  ;; :ensure t
  ;; :config
  ;; (run-geiser)
  )


;;; [ ac-geiser ]

;; (require 'ac-geiser)
;;
;; (dolist (hook '(lisp-mode-hook
;;                 lisp-interaction-mode-hook
;;                 scheme-mode-hook
;;                 ))
;;   (add-hook hook (lambda ()
;;                    (ac-geiser-setup)
;;                    (add-to-list 'ac-sources 'ac-source-geiser))))


;;; [ Quack ] -- enhanced Emacs Support for Editing and Running Scheme Code

;;; http://www.neilvandyke.org/quack/


;;; [ Guile Mode ]

;; (run-guile)


;;; [ GDS ] -- 



(provide 'init-my-prog-lang-lisp-scheme)

;;; init-my-prog-lang-lisp-scheme.el ends here
