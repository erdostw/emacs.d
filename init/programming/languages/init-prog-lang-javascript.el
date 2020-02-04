;;; init-prog-lang-javascript.el --- init JavaScript for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:


;;; Code:

;;; [ JavaScript ]

(use-package js
  :defer t
  :init
  (setq js-indent-level 2
        js-expr-indent-offset 0
        js-paren-indent-offset 0
        ;; js-square-indent-offset 0
        ;; js-curly-indent-offset 0
        ;; js-switch-indent-offset 0
        js-flat-functions nil))

;;; [ ob-js ]

(use-package ob-js
  :defer t
  :commands (org-babel-execute:js)
  :config
  (add-to-list 'org-babel-load-languages '(js . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))
  (add-to-list 'org-babel-default-header-args:js
               '(:results . "output"))

  (defun ob-js-insert-session-header-arg (session)
    "Insert ob-js `SESSION' header argument.
- `js-comint'
- `skewer-mode'
- `Indium'
"
    (interactive (list (completing-read "ob-js session: "
                                        '("js-comint" "skewer-mode" "indium"))))
    (org-babel-insert-header-arg
     "session"
     (pcase session
       ("js-comint" "\"*Javascript REPL*\"")
       ("skewer-mode" "\"*skewer-repl*\"")
       ("indium" "\"*JS REPL*\""))))
  (define-key org-babel-map (kbd "J") 'ob-js-insert-session-header-arg))

;;; [ js2-mode ]

(use-package js2-mode
  :ensure t
  :defer t
  :mode ("\\.js\\'" . js2-mode)
  :config
  (setq js2-mode-show-parse-errors nil ; highlight text with red face `js2-error'.
        js2-mode-show-strict-warnings t ; highlight warning in underline.
        ;; supress missing semicolon warnings
        js2-strict-missing-semi-warning nil
        js2-missing-semi-one-line-override t
        ;; externs
        js2-include-browser-externs t
        js2-include-node-externs t)

  (add-hook 'js-mode-hook #'js2-minor-mode)
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  
  ;; [ js2-refactor ] -- A JavaScript refactoring library for Emacs.
  (use-package js2-refactor
    :ensure t
    :init (add-hook 'js2-mode-hook #'js2-refactor-mode)
    (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
    :config (js2r-add-keybindings-with-prefix "M-RET"))

  ;; [ xref-js2 ] -- Jump to references/definitions using ag & js2-mode's AST in Emacs.
  (use-package xref-js2
    :ensure t
    :init
    (defun my/xref-js2-setup ()
      (define-key js2-mode-map (kbd "M-.") nil)
      (add-to-list (make-local-variable 'xref-backend-functions)
                   'xref-js2-xref-backend))
    (add-hook 'js2-mode-hook #'my/xref-js2-setup))

  (defun js-mode-electric-layout-setting ()
    "auto insert newline after specific characters."
    (setq-local electric-layout-rules '((?\; . after))))
  (add-hook 'js-mode-hook #'electric-layout-local-mode)
  (add-hook 'js-mode-hook #'js-mode-electric-layout-setting))

;;; [ flycheck checker ]

;; (defun js-mode-setup-flycheck-checkers ()
;;   "Disable jshint checker, so eslint will be used."
;;   ;; disable json checking (just my preference to not use it)
;;   (add-to-list 'flycheck-disabled-checkers 'javascript-jshint)
;;   (add-to-list 'flycheck-disabled-checkers 'json-jsonlist)
;;   (add-to-list 'flycheck-disabled-checkers 'javascript-jscs)
;;   ;; use eslint with web-mode for jsx files
;;   (flycheck-add-mode 'javascript-eslint 'web-mode)
;;   )
;;
;; (add-hook 'js2-mode-hook 'js-mode-setup-flycheck-checkers)
;;
;; (if (featurep 'js3-mode)
;;     (add-hook 'js3-mode-hook 'js-mode-setup-flycheck-checkers))

;;; [ nvm ] -- Manage Node versions within Emacs.

(use-package nvm
  :ensure t
  :init (nvm-use "v13.5.0"))

;; [ js-comint ] -- a lightweight comint integration.

(use-package js-comint
  :ensure t
  :defer t
  :commands (run-js)
  :config
  ;; if use node.js, we need nice output
  (setenv "NODE_NO_READLINE" "1")
  (setq js-comint-program-command "node")
  (setq js-comint-program-arguments '("--interactive"))
  (if (featurep 'nvm) (js-do-use-nvm))

  (defun my/js-comint-setup-keybindings ()
    "Add some custom keybindings for js-comint."
    (local-set-key (kbd "C-c C-s") 'run-js)
    (local-set-key (kbd "C-x C-e") 'js-send-last-sexp)
    (local-set-key (kbd "C-M-x") 'js-send-last-sexp-and-go)
    (local-set-key (kbd "C-c C-c") 'js-send-region)
    (local-set-key (kbd "C-c C-b") 'js-send-buffer)
    (local-set-key (kbd "C-c M-b") 'js-send-buffer-and-go))
  (add-hook 'js2-mode-hook #'my/js-comint-setup-keybindings)
  (add-to-list 'display-buffer-alist
               '("^\\*JavaScript REPL\\*" (display-buffer-below-selected))))

;;; [ nodejs-repl ] -- Run Node.js REPL and communicate the process.

;; (use-package nodejs-repl
;;   :ensure t
;;   :defer t
;;   :init (setenv "NODE_NO_READLINE" "1"))

;;; [ jscs (JavaScript Code Style) ]

;; (use-package jscs
;;   :ensure t
;;   :defer t
;;   :init
;;   ;; to apply JSCS indentation rules to JavaScript modes.
;;   (add-hook 'js-mode-hook #'jscs-indent-apply)
;;   (add-hook 'js2-mode-hook #'jscs-indent-apply)
;;   (add-hook 'js3-mode-hook #'jscs-indent-apply)
;;
;;   ;; to run "jscs --fix" on the current buffer when saving.
;;   ;; (add-hook 'js-mode-hook #'jscs-fix-run-before-save)
;;   ;; (add-hook 'js2-mode-hook #'jscs-fix-run-before-save)
;;   ;; (add-hook 'js3-mode-hook #'jscs-fix-run-before-save)
;;   )

;;; [ tern + company-tern ] -- Tern-powered JavaScript integration.

(use-package company-tern
  :ensure t
  :defer t
  :ensure tern
  :hook (js2-mode-hook . (lambda () (tern-mode 1) (my-company-add-backend-locally 'company-tern))))

;;; [ skewer-mode ] -- Live interactive web development in Emacs.

(use-package skewer-mode
  :ensure t
  :defer t
  :commands (run-skewer skewer-mode skewer-html-mode skewer-css-mode)
  :init (skewer-setup)
  (add-to-list 'display-buffer-alist
               '("\\*skewer-repl\\*" . (display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("\\*skewer-error\\*" . (display-buffer-below-selected)))
  ;; auto start httpd before `run-skewer'.
  (advice-add 'run-skewer :before #'httpd-start))

;;; [ Indium ] -- A JavaScript development environment for Emacs.

(use-package indium
  :ensure t
  :defer t
  :commands (indium-connect indium-launch)
  :init
  (add-to-list 'display-buffer-alist
               '("\\*JS REPL\\*" . (display-buffer-below-selected)))
  (setq indium-chrome-executable "google-chrome-unstable")
  ;; live JavaScript source edit and update.
  (setq indium-update-script-on-save t)
  :config
  ;; You can setup a hook to be run after each script update.
  (add-hook 'indium-update-script-source-hook
            (lambda (url)
              (indium-eval
               (format "window.dispatchEvent(new CustomEvent('patch', {detail: {url: '%s'}}))" url)))))

;;; [ lsp-javascript-typescript ] -- Javascript and Typescript support for lsp-mode using javascript-typescript-langserver.

(use-package lsp-mode
  :ensure t
  :ensure lsp-javascript-typescript
  :hook ((js-mode js2-mode rjsx-mode) . lsp))

;;; [ npm-mode ] -- minor mode for working with npm projects.

(use-package npm-mode
  :ensure t
  :defer t
  :init (add-hook 'js2-mode-hook #'npm-mode))

;;; [ jsx-mode ] -- The XML inside of JavaScript.

;; (use-package jsx-mode
;;   :ensure t
;;   :mode ("\\.jsx\\'" . jsx-mode))

;;; [ js-doc ] -- Insert JsDoc style comment easily.

;; (use-package js-doc
;;   :ensure t
;;   :init
;;   (add-hook 'js2-mode-hook
;;             #'(lambda ()
;;                 (define-key prog-comment-prefix (kbd "F") 'js-doc-insert-file-doc)
;;                 (define-key prog-comment-prefix (kbd "f") 'js-doc-insert-function-doc)
;;                 (define-key js2-mode-map (kbd "@") 'js-doc-insert-tag)))
;;   :config
;;   (setq js-doc-mail-address "numbchild@gmail.com"
;;         js-doc-author (format "stardiviner <%s>" js-doc-mail-address)
;;         js-doc-url "https://stardiviner.github.io/"
;;         js-doc-license "GPL3")
;;   )

;;; [ import-js ] -- A tool to simplify importing JS modules.

;; (use-package import-js
;;   :ensure t)

;;; [ js-import ] -- Automatically import JavaScript files from the current project or dependencies.

;; (use-package js-import
;;   :ensure t
;;   :defer t)

;;; [ js-format ] -- Format or transform code style using NodeJS server with different javascript formatter.

;; (use-package js-format
;;   :ensure t
;;   :config
;;   ;; using "standard" as js formatter
;;   (with-eval-after-load 'js2-mode
;;     (add-hook 'js2-mode-hook
;; 	      (lambda()
;; 		(js-format-setup "standard"))))
;;
;;   ;; using "jsbeautify-css" as css formatter
;;   (with-eval-after-load 'css-mode
;;     (add-hook 'css-mode-hook
;; 	      (lambda()
;; 		(js-format-setup "jsb-css"))))
;;   )

;;; [ flycheck-jest ] -- flycheck for Jest (Delightful JavaScript Testing)

;; (use-package flycheck-jest
;;   :ensure t
;;   :config
;;   (flycheck-jest-setup))

;;==============================================================================

;;; [ typescript-mode ] -- Major mode for editing typescript.

(use-package typescript-mode
  :ensure t
  :defer t)

;;; [ ob-typescript ] -- org-babel functions for typescript evaluation.

(use-package ob-typescript
  :defer t
  :commands (org-babel-execute:typescript)
  :config
  (add-to-list 'org-babel-load-languages '(typescript . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("typescript" . "ts"))
  (add-to-list 'org-babel-default-header-args:typescript '(:results . "output")))

;;; [ tide ] -- Typescript Interactive Development Environment.

(use-package tide
  :ensure t
  :defer t
  :after typescript-mode
  :commands (tide-mode)
  :init 
  (add-hook 'typescript-mode-hook #'tide-setup)
  (add-hook 'typescript-mode-hook #'tide-hl-identifier-mode))

;;; [ lsp-javascript-typescript ] -- Javascript and Typescript support for lsp-mode using javascript-typescript-langserver.

(use-package lsp-mode
  :ensure t
  :ensure lsp-javascript-typescript
  :hook ((typescript-mode) . lsp))


(provide 'init-prog-lang-javascript)

;;; init-prog-lang-javascript.el ends here
