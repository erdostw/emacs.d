;;; init-my-prog-lang-clojure.el --- init for Clojure.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ clojure-mode ]

(use-package clojure-mode
  :ensure t
  :defer t
  :config
  (autoload 'my-lisp-common-settings "init-my-prog-lang-lisp.el")
  (add-hook 'clojure-mode-hook #'my-lisp-common-settings)
  
  (autoload 'my-lisp-repl-common-settings "init-my-prog-lang-lisp.el")
  (add-hook 'clojure-repl-mode-hook #'my-lisp-repl-common-settings)

  ;; (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
  ;; `subword-mode' is quite useful since we often have to deal with Java class
  ;; and method names.
  (add-hook 'clojure-mode-hook #'subword-mode)

  (setq clojure-align-forms-automatically t)
  
  (with-eval-after-load 'clojure-mode
    (font-lock-add-keywords
     'clojure-mode `(("(\\(fn\\)[\[[:space:]]" ; (fn
                      (0 (progn (compose-region (match-beginning 1)
                                                (match-end 1) "λ")
                                nil)))))
    (font-lock-add-keywords
     'clojure-mode `(("\\(#\\)(" ; #(
                      (0 (progn (compose-region (match-beginning 1)
                                                (match-end 1) "ƒ")
                                nil)))))
    (font-lock-add-keywords
     'clojure-mode `(("\\(#\\){" ; #{
                      (0 (progn (compose-region (match-beginning 1)
                                                (match-end 1) "∈")
                                nil)))))
    (font-lock-add-keywords
     'clojure-mode `(("\\(#_\\)" ; #_
                      (0 (progn (compose-region (match-beginning 1)
                                                (match-end 1) "…")
                                nil)))))
    (font-lock-add-keywords
     'clojure-mode `(("\\(#\\)\"" ; #"regexp"
                      (0 (progn (compose-region (match-beginning 1)
                                                (match-end 1) "⋐")
                                nil)))))
    ;; `java.io.BufferedReader.' (class constructor)
    ;; (font-lock-add-keywords
    ;;  'clojure-mode `(("([^\\..*]*\\(\\.\\)\\{1\\}[\[:space:]\n)]"
    ;;                   (0 (progn (compose-region (match-beginning 1)
    ;;                                             (match-end 1) "⊿")
    ;;                             nil)))))
    )

  (use-package clojure-mode-extra-font-locking
    :ensure t)
  )


;;; [ CIDER ] -- CIDER is a Clojure IDE and REPL for Emacs

(use-package cider
  :ensure t
  :config
  (setq cider-auto-mode t
        nrepl-hide-special-buffers nil
        cider-repl-pop-to-buffer-on-connect nil
        cider-auto-select-error-buffer t
        nrepl-buffer-name-separator " "
        nrepl-buffer-name-show-port nil
        nrepl-log-messages t
        nrepl-prompt-to-kill-server-buffer-on-quit t

        ;; versions
        ;; cider-jack-in-auto-inject-clojure "1.9.0-alpha12"
        ;; cider-minimum-clojure-version "1.8.0"
        ;; cider-required-nrepl-version "0.2.12"
        
        ;; Leiningen parameters
        ;; cider-lein-command
        ;; cider-lein-global-options "-o"
        ;; cider-lein-parameters "repl :headless :host ::"
        
        ;; resources
        cider-prefer-local-resources t

        ;; font-lock
        cider-font-lock-dynamically '(macro core deprecated function)

        ;; indent
        cider-dynamic-indentation t
        
        ;; REPL
        cider-inject-dependencies-at-jack-in t
        cider-repl-display-in-current-window nil
        cider-repl-pop-to-buffer-on-connect nil
        cider-save-file-on-load t
        cider-repl-result-prefix ";; => "
        cider-repl-use-clojure-font-lock t
        ;; cider-repl-tab-command 'cider-repl-indent-and-complete-symbol
        ;; cider-known-endpoints '(("host-a" "10.10.10.1" "7888") ("host-b" "7888"))
        cider-repl-use-pretty-printing t
        cider-repl-wrap-history t
        cider-repl-history-size 500
        cider-repl-history-file nil
        cider-show-error-buffer t

        ;; ClojureScript
        ;; cider-cljs-lein-repl
        ;; cider-cljs-boot-repl
        ;; cider-cljs-gradle-repl
        
        ;; pretty-printing
        ;; cider-pprint-fn 'fipp
        
        ;; Eval
        cider-show-eval-spinner t
        cider-eval-spinner-delay 1
        cider-eval-spinner-type 'progress-bar
        cider-use-overlays 'both
        cider-overlays-use-font-lock t ; use overlay for results.
        cider-result-use-clojure-font-lock t
        cider-eval-result-duration 'command

        ;; Enlighten

        ;; Fringe linter
        cider-use-fringe-indicators t

        ;; mouse over tooltips
        cider-use-tooltips t
        
        ;; Compilation
        cider-auto-jump-to-error 'errors-only
        cider-auto-select-error-buffer t

        ;; clojure.test
        cider-test-show-report-on-success nil

        ;; stacktraces
        cider-show-error-buffer t
        cider-auto-select-error-buffer t
        cider-stacktrace-default-filters '(tooling dup)

        ;; debugging

        ;; code reloading
        cider-refresh-show-log-buffer t

        ;; multiple connections
        cider-request-dispatch 'dynamic

        ;; Mode Line
        cider-mode-line-show-connection t

        ;; project
        cider-prompt-for-project-on-connect 'when-needed

        ;; build tool
        ;; cider-preferred-build-tool "boot"
        )

  ;; Complete & annotations
  (setq cider-completion-use-context t
        cider-annotate-completion-candidates t
        ;; cider-completion-annotations-include-ns 'always ; 'unqualified
        cider-completion-annotations-alist '(("class" "class")
                                             ("field" "field")
                                             ("function" "λ") ; f, λ, ƒ
                                             ("import" "import")
                                             ("keyword" "k")
                                             ("local" "l")
                                             ("macro" "macro")
                                             ("method" "method")
                                             ("namespace" "ns")
                                             ("protocol" "protocol")
                                             ("protocol-function" "protocol-function")
                                             ("record" "record")
                                             ("special-form" "special-form")
                                             ("static-field" "static-firld")
                                             ("static-method" "static-method")
                                             ("type" "type")
                                             ("var" "v"))
        )

  ;; Java

  ;; Enlighten faces
  ;; `cider-enlighten-mode' will extremely slow down Clojure/CIDER evaluation.
  ;; (add-hook 'cider-mode-hook #'cider-enlighten-mode)

  ;; auto completion with company-mode support
  ;; `cider-complete-at-point' in `completion-at-point-functions'
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  ;; enable fuzzy completion for CIDER
  ;; (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  ;; (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)

  (setq cider-doc-auto-select-buffer t)
  
  ;; (use-package cider-hydra
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'cider-mode-hook #'cider-hydra-mode)
  ;;   (add-hook 'cider-repl-mode-hook #'cider-hydra-mode))
  
  ;; enable `eldoc' in relevant buffers.
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook
            (lambda ()
              (if (bound-and-true-p eldoc-overlay-mode)
                  (setq-local eldoc-message-function #'eldoc-minibuffer-message))))
  (setq cider-eldoc-display-for-symbol-at-point nil
        cider-eldoc-display-context-dependent-info t ; for datomic query input parameters
        )

  (add-hook 'cider-repl-mode-hook #'subword-mode)

  ;; enable `cider-mode' in `clojure-mode'.
  (add-hook 'clojure-mode-hook #'cider-mode)
  
  (setq cider-allow-jack-in-without-project t)
  ;; (add-hook 'after-init-hook #'cider-jack-in)

  ;; notify user CIDER is connected.
  (add-hook 'cider-connected-hook
            (lambda ()
              (notifications-notify :title "CIDER connected"
                                    :body "CIDER process connected.")))
  
  ;; CIDER inspect command keybindings
  (unless (boundp 'cider-inspect-prefix)
    (define-prefix-command 'cider-inspect-prefix))

  (add-hook 'clojure-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c i") 'cider-inspect-prefix)
              (define-key cider-inspect-prefix (kbd "r") 'cider-inspect-last-result)
              (define-key cider-inspect-prefix (kbd "E") 'cider-inspect-expr)
              (define-key cider-inspect-prefix (kbd "d") 'cider-inspect-defun-at-point)
              (define-key cider-inspect-prefix (kbd "e") 'cider-inspect-last-sexp)
              (define-key cider-inspect-prefix (kbd "i") 'cider-inspect-read-and-inspect)
              ))

  
  (defconst cider-metadata-buffer "*cider-metadata*")

  (defun cider-metadata (var &optional ns)
    "Show VAR's metadata in a separate buffer.

Optional argument NS, if not provided, defaults to
`cider-current-ns'."
    (interactive (list (cider-symbol-at-point)))
    (let* ((buf (current-buffer))
           (result-buffer (cider-popup-buffer cider-metadata-buffer t 'clojure-mode t))
           (handler (cider-popup-eval-out-handler result-buffer)))
      (with-current-buffer buf
        (cider-interactive-eval
         (format "(meta (var %s))" (concat (or ns (cider-current-ns)) "/" var))
         handler
         nil
         (cider--nrepl-pprint-request-plist (cider--pretty-print-width))))))

  ;; [ helm-cider ] -- Helm interface to CIDER.
  (use-package helm-cider
    :ensure t
    :config
    (add-hook 'cider-mode-hook #'helm-cider-mode))

  ;; bind keybindings to some not-bind wrapping functions in clojure-mode locally.
  (add-hook 'clojure-mode-hook
            (lambda ()
              (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
              (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly))
            nil 'local)

  ;; CIDER helper functions
  (defun my/cider-repl-eval (input)
    "Execute Clojure `INPUT' in CIDER REPL.

Usage: (my/cider-repl-eval \"\(clojure expr\)\")"
    (notifications-notify
     :title "CIDER nREPL evaluation starting."
     :body input)
    (cider-interactive-eval input
                            #'(lambda (event)
                                (notifications-notify
                                 :title "CIDER form evaluation finished.")))
    (sit-for 5)
    )
  
  (add-hook 'cider-connected-hook
            #'(lambda ()
                (sit-for 10)
                ;; import Java object static methods like `.getCanonicalFile'.
                (my/cider-repl-eval "(import [java.io File InputStream])")
                ;; load Incanter commonly usaed namespaces.
                ;; (my/cider-repl-eval "(use '(incanter core stats datasets charts io pdf))")
                (my/cider-repl-eval "(use '(incanter stats charts))")
                ) t)
  )


;;; run test when load file.

(defun cider-tdd-test ()
  "Thin wrapper around `cider-test-run-tests'."
  (when (cider-connected-p)
    (let ((cider-auto-select-test-report-buffer nil)
          (cider-test-show-report-on-success nil))
      (cider-test-run-ns-tests nil)
      (message "CIDER TDD test run successfully."))))

(define-minor-mode cider-tdd-mode
  "Run all tests whenever a file is saved."
  t nil nil
  :global t
  (if cider-tdd-mode
      (add-hook 'cider-file-loaded-hook #'cider-tdd-test)
    (remove-hook 'cider-file-loaded-hook #'cider-tdd-test)))

;; (add-hook 'clojure-mode-hook 'cider-tdd-mode)



;;; [ flycheck-clojure, squiggly-clojure ] --

(use-package flycheck-clojure
  :ensure t
  :init
  (with-eval-after-load 'flycheck
    (flycheck-clojure-setup))
  )


;;; [ clj-refactor ]

(use-package clj-refactor
  :ensure t
  :config
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clj-refactor-mode 1)
              ;; insert keybinding setup here
              (cljr-add-keybindings-with-prefix "M-RET")
              ))

  (define-key clj-refactor-map (kbd "C-c C-'") #'hydra-cljr-help-menu/body)

  ;; skip Tab in `cljr-add-require-to-ns' snippet.
  ;; (advice-add 'cljr-add-require-to-ns :after
  ;;             (lambda (&rest _)
  ;;               (yas-next-field)
  ;;               (yas-next-field)))
  )

;;; [ kibit-helper ] -- Conveniently use the Kibit Leiningen plugin from Emacs.

(use-package kibit-helper
  :ensure t
  :commands (kibit kibit-current-file kibit-accept-proposed-change)
  :bind (:map clojure-mode-map
              ("C-x C-`" . kibit-accept-proposed-change))
  )

;;; [ cider-decompile ] -- decompilation extension for cider.

;; (use-package cider-decompile
;;   :ensure t
;;   :bind (:map clojure-mode-map
;;               ("??" . cider-decompile-func)
;;               ("??" . cider-decompile-ns-func))
;;   )


;;; [ cider-spy ] -- Spy on CIDER to get Info.

;; (use-package cider-spy
;;   :ensure t
;;   :defer t)


;;; [ cider-profile ]

(use-package cider-profile
  :ensure t
  :defer t
  :init
  (add-hook 'cider-mode-hook 'cider-profile-mode)
  (add-hook 'cider-repl-mode-hook 'cider-profile-mode)
  :config
  ;; If you would like to display profiling statistics in the current repl
  ;; window instead of in a pop-up window, do the following:
  ;; (setq cider-profile-buffer nil)
  )


;;; Org-mode Babel Clojure
(require 'ob-clojure)

(add-to-list 'org-babel-load-languages '(clojure . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
(add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))

(setq org-babel-clojure-backend 'cider)

;; whether check Org-mode buffer's (ns ) declarations.
;; (setq cider-auto-track-ns-form-changes t)

;; No timeout when executing calls on Cider via nrepl
;; (setq org-babel-clojure-sync-nrepl-timeout nil)

;; let `ob-clojure' babel src blocks allow evaluation.
(add-to-list 'org-babel-default-header-args:clojure
             '(:eval . "yes"))
(add-to-list 'org-babel-default-header-args:clojure
             '(:results . "value pp"))
;; (add-to-list 'org-babel-default-header-args:clojure ; for Clojure `dotimes' etc.
;;              '(:show-process . "no"))
(add-to-list 'org-babel-default-header-args:clojure
             '(:noweb . "yes"))
(add-to-list 'org-babel-default-header-args:clojure
             '(:session "*cider-repl ob-clojure*"))

;; auto start CIDER REPL session in a complete Leiningen project environment for Org-mode Babel by jack-in.
(progn
  (find-file (expand-file-name "~/.emacs.d/Org-mode/ob-clojure/src/ob_clojure/core.clj"))
  (cider-jack-in))


;;; [ typed-clojure-mode ] -- Typed Clojure minor mode for Emacs.

;; (use-package typed-clojure-mode
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-hook 'clojure-mode-hook 'typed-clojure-mode)
;;   )


;;; [ helm-clojuredocs ] -- Searching for help in clojurdocs.org with Helm.

(use-package helm-clojuredocs
  :ensure t
  :defer t
  :bind (:map clojure-mode-map
              ("C-h d d" . helm-clojuredocs))
  )

;;; [ clojure-cheatsheet ] -- The Clojure Cheatsheet for Emacs.

(use-package clojure-cheatsheet
  :ensure t
  :bind (:map clojure-mode-map
              ("C-c C-h" . clojure-cheatsheet))
  )


;;; [ elein ] -- running Leiningen commands from Emacs.

(use-package elein
  :ensure t)

(defun elein-lein-try ()
  (interactive)
  (if (equal "*scratch*" (buffer-name))
      (progn
        (setq-local inferior-lisp-program "lein try tentacles")
        (command-execute 'inferior-lisp)
        )))

;;; [ Boot ]

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode)) ; recognize .boot file
(add-to-list 'magic-mode-alist '(".* boot" . clojure-mode)) ; recognize script file using shebang


;;; [ clomacs ] -- Clomacs simplifies call Clojure code from Emacs lisp.

(use-package clomacs
  :ensure t
  :defer t)

;;; [ cljsbuild-mode ] -- A minor mode for the ClojureScript 'lein cljsbuild' command.

(use-package cljsbuild-mode
  :ensure t)

;;; [ 4clojure ] -- Open and evaluate 4clojure.com questions in Emacs.

(use-package 4clojure
  :ensure t
  :config
  (defadvice 4clojure-open-question (around 4clojure-open-question-around)
    "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
    ad-do-it
    (unless cider-current-clojure-buffer
      (cider-jack-in)))
;;; [ YeSQL Ghosts ] -- Display ghostly YeSQL defqueries inline, in Emacs.

(use-package yesql-ghosts
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'yesql-ghosts-auto-show-ghosts)
  (setq yesql-ghosts-show-ghosts-automatically t
        yesql-ghosts-show-descriptions t)
  )

;;; [ HugSQL Ghosts ] -- Display ghostly HugSQL defqueries inline, in Emacs.

(use-package hugsql-ghosts
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'hugsql-ghosts-install-hook)
  (setq hugsql-ghosts-newline-before-docstrings t)
  )



(provide 'init-my-prog-lang-clojure)

;;; init-my-prog-lang-clojure.el ends here
