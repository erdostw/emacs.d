;;; init-prog-lang-C-common.el --- C-like programming languages common init.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ CC-mode ]

;; cc-mode provides:
;; - c-mode
;; - c++-mode
;; - java-mode
;; - objc-mode
;; - and some 3rd part modes.

(use-package cc-mode
  :defer t
  :init
  (setq-default c-default-style '((java-mode . "java")
                                  (awk-mode . "awk")
                                  (other . "gnu")))
  
  ;; indent
  (setq-default c-syntactic-indentation t
                c-basic-offset 2
                tab-width 2
                indent-tabs-mode nil    ; never use tab, always use space only.
                tab-always-indent t ; make tab key always call a indent command.
                )
  ;; Do not check for old-style (K&R) function declarations; this speeds up
  ;; indenting a lot.
  (setq c-recognize-knr-p nil)

  ;; Hook called by all CC Mode modes for common initializations.
  ;; (add-hook 'c-mode-common-hook)

  :config
  (defvar c-dialects-mode
    '(c-mode
      c++-mode
      objc-mode))

  (hook-modes c-dialects-mode
    ;; (c-toggle-auto-hungry-state 1)
    ;; (c-toggle-auto-newline 1)
    ;; (c-toggle-hungry-state 1)
    (electric-indent-local-mode 1)
    (electric-pair-local-mode 1))

  ;;; auto insert newline in c-mode
  ;; (add-hook 'c-mode-hook #'c-toggle-auto-newline)

  (require 'cc-mode) ; load for `c-mode-base-map'
  (add-hook 'c-mode-hook #'electric-layout-local-mode)
  (define-key c-mode-base-map ";" nil) ; fix ";" not work for `electric-layout-local-mode' issue.
  (defun c-mode-electric-layout-setting ()
    "auto insert newline after specific characters."
    (setq-local electric-layout-rules '((?\; . after)))
    (add-to-list 'electric-layout-rules '( ?\{ .  after))
    (add-to-list 'electric-layout-rules '( ?\} .  before)))
  (add-hook 'c-mode-hook #'c-mode-electric-layout-setting)

  ;; open header file
  (defun my/c-mode-common-header-switch ()
    "Open header file at point."
    (local-set-key (kbd "C-c C-o") 'ff-find-other-file))
  (add-hook 'c-mode-common-hook #'my/c-mode-common-header-switch))

;;; [ modern-cpp-font-lock ] -- Font-locking for "Modern C++"

(use-package modern-cpp-font-lock
  :ensure t
  :defer t
  :hook (c++-mode-hook . modern-c++-font-lock-mode))

;;; [ ob-C ]

(use-package ob-C
  :defer t
  :commands (org-babel-execute:C org-babel-execute:C++)
  :config
  (add-to-list 'org-babel-load-languages '(C . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("C" . "c"))
  (add-to-list 'org-babel-tangle-lang-exts '("C++" . "cpp"))
  
  ;; (setq org-babel-C++-compiler "g++") ; "g++", "c++", "g++ -v"
  (add-to-list 'org-babel-default-header-args:C
               '(:results . "output"))
  ;; (add-to-list 'org-babel-default-header-args:C++
  ;;              '(:results . "output"))
  )

;;; [ semantic-mode ]

;;; NOTE disable global `semantic-mode'
;; (hook-modes c-dialects-mode
;;   (when (memq major-mode '(c-mode c++-mode objc-mode))
;;     (semantic-mode 1)))

;;; [ Irony-mode ] --- A C/C++ minor mode for Emacs powered by libclang.

(use-package irony
  :ensure t
  :defer t
  :hook ((c-mode . irony-mode)
         (c++-mode . irony-mode)
         (objc-mode . irony-mode))
  :config
  ;; find the compile flag options automatically:
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (use-package company-irony
    :ensure t
    :ensure company-irony-c-headers
    :after irony
    :init (setq company-irony-ignore-case t)
    :config
    (defun my/company-irony-setup ()
      ;; (optional) adds CC special commands to `company-begin-commands'
      ;; in order to trigger completion at interesting places, such as
      ;; after scope operator.
      ;;     std::|
      (company-irony-setup-begin-commands)
      (make-local-variable 'company-backends)
      (my-company-add-backend-locally 'company-irony)
      (add-to-list 'company-backends 'company-irony-c-headers)
      (setq-local company-minimum-prefix-length 1))

    (dolist (hook '(c-mode-hook
                    c++-mode-hook
                    objc-mode-hook))
      (add-hook hook #'my/company-irony-setup)))

  (use-package irony-eldoc
    :ensure t
    :defer t
    :after irony
    :init (add-hook 'irony-mode-hook #'irony-eldoc))

  (use-package flycheck-irony
    :ensure t
    :defer t
    :after irony
    :init (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

;;; [ cquery ] -- Low-latency language server supporting multi-million line C++ code-bases, powered by libclang.

;; (use-package cquery
;;   :ensure t
;;   :defer t
;;   :init
;;   (defun my:cquery-setup ()
;;     (when
;;         (or (locate-dominating-file default-directory "compile_commands.json")
;;             (locate-dominating-file default-directory ".cquery"))
;;       (lsp-cquery-enable)))
;;   (add-hook 'c-mode-common-hook #'my:cquery-setup))

;;; [ ccls ] -- C/C++/Objective-C lang server support for lsp-mode using Clang.

;; (use-package ccls
;;   :ensure t
;;   :defer t
;;   :defines projectile-project-root-files-top-down-recurring
;;   :ensure t
;;   :after lsp
;;   :commands lsp-ccls-enable
;;   :load ccls
;;   :hook ((c-mode c++-mode objc-mode) . lsp)
;;   :config (with-eval-after-load 'projectile
;;             (setq projectile-project-root-files-top-down-recurring
;;                   (append '("compile_commands.json" ".ccls")
;;                           projectile-project-root-files-top-down-recurring))))

;;; [ flycheck-cstyle ] -- Integrate cstyle with flycheck.

;; (use-package flycheck-cstyle
;;   :ensure t
;;   :defer t
;;   :after flycheck
;;   :config
;;   (flycheck-cstyle-setup)
;;   (flycheck-add-next-checker 'c/c++-cppcheck '(warning . cstyle))
;;   ;; (flycheck-add-next-checker 'c/c++-clang '(warning . cstyle))
;;   )

;;; [ flycheck-clang-analyzer ] -- Integrate Clang Static Analyzer with flycheck for on-the-fly static analysis in Emacs.

;; (use-package flycheck-clang-analyzer
;;   :ensure t
;;   :defer t
;;   :after flycheck
;;   :config (flycheck-clang-analyzer-setup))


(require 'init-prog-tags)



(provide 'init-prog-lang-C-common)

;;; init-prog-lang-C-common.el ends here
