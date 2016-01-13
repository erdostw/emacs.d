;;; init-my-prog-lang-C-common.el --- C-like programming languages common init.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ CC-mode ]

;; cc-mode provides:
;; - c-mode
;; - c++-mode
;; - java-mode
;; - objc-mode
;; - idl-mode
;; - pike-mode
;; - awk-mode
;; - and some 3rd part modes.

;; (require 'cc-mode)

;; Hook called by all CC Mode modes for common initializations.
;; (add-hook 'c-mode-common-hook)


;; [ C-mode ]

(setq-default c-syntactic-indentation t
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil ; never use tab, always use space only.
              tab-always-indent t ; make tab key always call a indent command.
              c-default-style "linux"
              )


;;; [ Irony-mode ] --- A C/C++ minor mode for Emacs powered by libclang.

;;; irony-mode is an Emacs minor-mode that aims at improving the editing
;;; experience for the C, C++ and Objective-C languages. It works by using a
;;; combination of an Emacs package and a C++ program (irony-server) that uses
;;; libclang.

;;; On the first run, irony-mode will ask you to build and install
;;; irony-server. To do so, type [M-x irony-install-server RET].

;;; In order to work correctly, irony-mode needs to know the compile
;;; flags. `irony-cdb' aims to provide as automatic as possible compile flags
;;; discovery, with minimal user input.

;;; Usage:
;;
;; - `irony-server' :: irony-server provides the libclang interface to
;;                     irony-mode. It uses a simple protocol based on
;;                     S-expression.
;;
;; On the first run, irony-mode will ask you to build and install
;; irony-server. To do so, type M-x `irony-install-server' RET.
;;
;;
;;; Compilation Database
;;
;; In order to work correctly, irony-mode needs to know the compile
;; flags. irony-cdb aims to provide as automatic as possible compile flags
;; discovery, with minimal user input.
;;
;; Please refer to `irony-cdb-autosetup-compile-options' and
;; `irony-cdb-compilation-databases'.

(use-package irony-mode
  :init
  (hook-modes c-dialects-mode
    (when (member major-mode irony-supported-major-modes)
      (irony-mode 1)))

  (hook-modes c-dialects-mode
    (c-toggle-auto-newline 1)
    ;; (c-toggle-auto-hungry-state 1)
    (electric-indent-mode 1)
    (turn-on-eldoc-mode)

    (my-company-add-backends-to-mode
     '(company-gtags
       company-etags
       company-cmake))
    )
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (add-hook 'irony-mode-hook
            (lambda ()
              (define-key irony-mode-map [remap completion-at-point]
                'irony-completion-at-point-async)
              (define-key irony-mode-map [remap complete-symbol]
                'irony-completion-at-point-async)
              ))
  )


;;; [ company-irony ]

(use-package company-irony
  :config
  (add-hook 'irony-mode-hook
            '(lambda ()
               (my-company-add-backends-to-mode
                '(company-irony-c-headers
                  company-irony))
               
               ;; (optional) adds CC special commands to `company-begin-commands'
               ;; in order to trigger completion at interesting places, such as
               ;; after scope operator.
               ;;     std::|
               (company-irony-setup-begin-commands)
               ))
  )


;;; [ irony-eldoc ]

(with-eval-after-load 'irony
  (add-hook 'irony-mode-hook #'irony-eldoc))


;;; [ flycheck-irony ]

(with-eval-after-load 'irony
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;;; [ company-clang ]

;; (use-package company-clang
;;   :config
;;   ;; (setq company-clang-arguments
;;   ;;       company-clang-prefix-guesser 'company-clang-guess-prefix
;;   ;;       )
;;   (setq company-clang-begin-after-member-access t)
;;
;;   (hook-modes c-dialects-mode
;;     (my-company-add-backends-to-mode '(company-clang)))
;;   )


;;; [ company-c-headers ]

;; (use-package company-c-headers
;;   :config
;;   (hook-modes c-dialects-mode
;;     (add-to-list (make-local-variable 'company-backends)
;;                  'company-c-headers))
;;   )


;;; [ gccsense ]

;; (unless (package-installed-p 'gccsense)
;;   (package-install 'gccsense))
;; (require 'gccsense)



;;; [ function-args ] -- showing an inline arguments hint for the C/C++ function at point.

;; (use-package function-args
;;   :config
;;
;;   (autoload 'turn-on-function-args-mode "function-args" nil t)
;;
;;   ;; FIXME: function-args use semantic-mode, it caused python-interpreter suspend on Emacs startup.
;;   (add-hook 'c-mode-hook 'turn-on-function-args-mode)
;;   (add-hook 'c++-mode-hook 'turn-on-function-args-mode)
;;
;;
;;   ;; Put c++-mode as default for *.h files (improves parsing):
;;   ;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;;   ;;
;;   ;; Enable case-insensitive searching:
;;   ;; (set-default 'semantic-case-fold t)
;;   ;;
;;   ;; If your includes aren't located in default dirs e.g. /usr/include/ etc, then
;;   ;; you have to do something like this:
;;   ;; (semantic-add-system-include "~/Software/deal.II/include/" 'c++-mode)
;;   ;; (semantic-add-system-include "/usr/local/boost_1_54_0/" 'c++-mode)
;;   ;;
;;   ;; You can add this to improve the parse of macro-heavy code:
;;   ;; (require 'semantic/bovine/c)
;;   ;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;   ;;              "/usr/lib/gcc/x86_64-linux-gnu/4.8/include/stddef.h")
;;   )


;;; [ rtags ]

;;; https://github.com/Andersbakken/rtags




(provide 'init-my-prog-lang-C-common)

;;; init-my-prog-lang-C-common.el ends here
