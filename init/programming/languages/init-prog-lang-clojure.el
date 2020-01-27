;;; init-prog-lang-clojure.el --- init for Clojure.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ clojure-mode ]

(use-package clojure-mode ; [C-c C-r] prefix
  :ensure t
  :defer t
  :commands (clojure-add-arity)
  :init (setq clojure-align-forms-automatically t)
  :config
  (autoload 'my-lisp-common-settings "init-prog-lang-lisp.el")
  (add-hook 'clojure-mode-hook #'my-lisp-common-settings)
  
  (autoload 'my-lisp-repl-common-settings "init-prog-lang-lisp.el")
  (add-hook 'cider-repl-mode-hook #'my-lisp-repl-common-settings)

  ;; (add-hook 'clojure-mode-hook 'smartparens-strict-mode)

  ;; treat `foo-bar' or `:baz' as a symbol.
  ;; (add-hook 'clojure-mode-hook
  ;;           (lambda ()
  ;;             (dolist (c (string-to-list ":_-?!#*"))
  ;;               (modify-syntax-entry c "w" clojure-mode-syntax-table))))

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

  ;; make the [M-;] and `banner-comment' works correct.
  (add-hook 'clojure-mode-hook (lambda () (setq-local comment-start ";;"))))

(use-package clojure-mode-extra-font-locking
  :ensure t
  :defer t
  :after clojure-mode)

;; `subword-mode' is quite useful since we often have to deal with Java class
;; and method names.
(use-package subword
  :ensure t
  :defer t
  :init (add-hook 'clojure-mode-hook 'subword-mode))

;;; [ inf-clojure ] -- Run an external Clojure process in an Emacs buffer.

;; (use-package inf-clojure
;;   :ensure t
;;   :defer t
;;   :commands (inf-clojure)
;;   :init
;;   (add-to-list 'display-buffer-alist
;;                '("^\\*inf-clojure*\\*" (display-buffer-reuse-window display-buffer-below-selected)))
;;   ;; :init (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)
;;   :config
;;   ;; fix `inf-clojure-minor-mode' conflict wiith `cider-imode' in Clojure buffer of `ob-clojure'.
;;   ;; (defun inf-clojure-disable-clojure (&optional arg)
;;   ;;   (cider-mode -1)
;;   ;;   (inf-clojure-minor-mode 1))
;;   ;; (advice-add 'org-edit-special :after 'inf-clojure-disable-clojure)
;;   ;; (add-hook 'inf-clojure-mode-hook #'subword-mode)
;;
;;   ;; FIXME: it caused auto add newlines.
;;   ;; (add-hook 'inf-clojure-mode-hook #'eldoc-mode)
;;   ;; manage inf-clojure popup buffers.
;;   )

;;; [ CIDER ] -- CIDER is a Clojure IDE and REPL for Emacs

(use-package cider
  :ensure t
  :defer t
  :commands (cider-jack-in)
  :after clojure-mode
  :init
  ;; manage CIDER popup buffers.
  (add-to-list 'display-buffer-alist
               '("^\\*cider-.*\\*" (display-buffer-reuse-window display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("^\\*nrepl-.*\\*" (display-buffer-reuse-window display-buffer-below-selected)))
  :config
  ;; Clojure
  ;; (setq cider-default-repl-command 'clojure-cli)
  ;; ClojureScript
  (setq cider-default-cljs-repl 'shadow)

  ;; Frequently used connections
  ;; TODO: need to know how to run Docker container REPL with specific port.
  ;; $ docker run --name clojure -p :7788 -it clojure:tools-deps clj
  ;; (setq cider-known-endpoints '(("docker-clojure" "127.0.0.1" "7888")))
  
  (setq cider-font-lock-dynamically '(macro core deprecated function)
        ;; cider-prefer-local-resources t
        ;; cider-dynamic-indentation nil
        cider-repl-result-prefix ";; => "
        cider-result-overlay-position 'at-eol)

  ;; Enlighten faces
  ;; NOTE `cider-enlighten-mode' will extremely slow down Clojure/CIDER evaluation.
  (defun my/cider-enlighten-mode-enable ()
    "Enable `cider-enlighten-mode' only when in real Clojure
    source code file instead of virtual temprary buffer like Org
    Babel opened buffers."
    (unless (buffer-file-name)
      (cider-enlighten-mode)))
  (add-hook 'cider-mode-hook #'my/cider-enlighten-mode-enable)

  ;; auto completion with company-mode support
  ;; `cider-complete-at-point' in `completion-at-point-functions'
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  ;; (use-package cider-hydra
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'cider-mode-hook #'cider-hydra-mode)
  ;;   (add-hook 'cider-repl-mode-hook #'cider-hydra-mode))
  
  ;; enable `eldoc' in relevant buffers.
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  ;; (add-hook 'cider-repl-mode-hook #'cider-repl-require-repl-utils) ; require common functions like doc, source, etc.
  (setq cider-eldoc-display-for-symbol-at-point t
        cider-eldoc-display-context-dependent-info t)

  ;; (setq cider-jump-to-pop-to-buffer-actions '((display-buffer-reuse-window (window-height . 0.3))))

  (add-hook 'cider-repl-mode-hook #'subword-mode)
  
  ;; auto inject Clojure dependencies.
  ;; (cider-add-to-alist 'cider-jack-in-dependencies "org.clojure/tools.nrepl" "0.2.13")
  ;; hot load dependencies.
  (add-to-list 'cider-jack-in-dependencies '("com.cemerick/pomegranate" "1.1.0"))
  (add-to-list 'cider-jack-in-dependencies '("datawalk" "0.1.12"))
  (add-to-list 'cider-jack-in-dependencies '("io.github.erdos/erdos.assert" "0.1.0"))
  (add-to-list 'cider-jack-in-dependencies '("criterium" "0.4.4"))
  ;; auto add incanter as dependency for Org Mode clojure Babel generate plot image result.
  ;; (add-to-list 'cider-jack-in-dependencies '("incanter" "1.9.2"))
  ;; Check out function `cljr--inject-jack-in-dependencies'.
  
  ;; notify user CIDER is connected.
  ;; (add-hook 'cider-connected-hook
  ;;           (lambda ()
  ;;             (notifications-notify :title "CIDER connected"
  ;;                                   :body "CIDER process connected.")))

  ;; [ cider-profile ] [C-c C-=]
  
  ;; CIDER inspect command keybindings [C-c M-i] `cider-inspect'.
  (unless (boundp 'cider-inspect-prefix)
    (define-prefix-command 'cider-inspect-prefix))
  (defun my:cider-setup-inspect-keybindings ()
    (local-set-key (kbd "C-c i") 'cider-inspect-prefix)
    (define-key cider-inspect-prefix (kbd "r") 'cider-inspect-last-result)
    (define-key cider-inspect-prefix (kbd "E") 'cider-inspect-expr)
    (define-key cider-inspect-prefix (kbd "d") 'cider-inspect-defun-at-point)
    (define-key cider-inspect-prefix (kbd "e") 'cider-inspect-last-sexp))
  (add-hook 'clojure-mode-hook #'my:cider-setup-inspect-keybindings)
  
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
  (define-key cider-inspect-prefix (kbd "m") 'cider-metadata)

  ;; bind keybindings to some not-bind wrapping functions in clojure-mode locally.
  (add-hook 'clojure-mode-hook
            (lambda ()
              (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
              (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly))
            nil 'local)

  ;; REPL history
  (define-key cider-repl-mode-map (kbd "M-r") 'cider-repl-history)

  ;; Clojure dot operator with yasnippet for Object methods completion.
  (setq yas-inhibit-overlay-modification-protection t)
  ;; (advice-add 'yas--on-protection-overlay-modification :override #'ignore) ; fix $0 placeholder gone issue.
  
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
    (sit-for 5))
  
  ;; (add-hook 'cider-connected-hook
  ;;           #'(lambda ()
  ;;               (sit-for 10)
  ;;               ;; import Java object static methods like `.getCanonicalFile'.
  ;;               (my/cider-repl-eval "(import [java.io File InputStream])")
  ;;               ;; load Incanter commonly usaed namespaces.
  ;;               ;; (my/cider-repl-eval "(use '(incanter core stats datasets charts io pdf))")
  ;;               (my/cider-repl-eval "(use '(incanter stats charts))")
  ;;               ) t)
  )

;; [ helm-cider ] -- Helm interface to CIDER.

(use-package helm-cider
  :ensure t
  :after cider
  :bind (:map cider-doc-map
              ("c" . helm-cider-cheatsheet)
              ("C-c" . helm-cider-cheatsheet))
  :init (add-hook 'cider-mode-hook #'helm-cider-mode))

;;; [ clj-refactor ] -- A collection of commands for refactoring Clojure code.

(use-package clj-refactor
  :ensure t
  :defer t
  :after clojure-mode
  :delight clj-refactor-mode
  :init (setq cljr-suppress-middleware-warnings t)
  :config
  (defun my:clj-refactor-setup ()
    (clj-refactor-mode 1)
    ;; (cljr-add-keybindings-with-prefix "C-c C-m")
    (define-key clj-refactor-map (kbd "C-c C-m") #'hydra-cljr-help-menu/body))
  (add-hook 'clojure-mode-hook #'my:clj-refactor-setup)
  (add-hook 'cider-repl-mode-hook #'my:clj-refactor-setup)
  ;; :config
  ;; skip Tab in `cljr-add-require-to-ns' snippet.
  ;; (advice-add 'cljr-add-require-to-ns :after
  ;;             (lambda (&rest _)
  ;;               (yas-next-field)
  ;;               (yas-next-field)))

  ;; FIXME: temporary solution for clj-refactor.
  (with-eval-after-load "clj-refactor"
    (remove-hook 'find-file-hook #'cljr--ensure-no-dashes-in-filename))
  
  (add-to-list 'display-buffer-alist
               '("^\\*cljr-*\\*" . (display-buffer-below-selected))))

;;; [ debux.el ] -- Integrate Clojure/ClojureScript debugger "Debux" into Emacs.

;; TODO: https://github.com/philoskim/debux
;; (use-package debux
;;   :load-path "~/Code/Emacs/debux/"
;;   ;; :config
;;   )

;;; [ flycheck-clojure, squiggly-clojure ] --

;; (use-package flycheck-clojure
;;   :ensure t
;;   :defer t
;;   :after flycheck
;;   :init (flycheck-clojure-setup))

;;; [ flycheck-clj-kondo ] -- Emacs integration for clj-kondo via flycheck.

;; (use-package flycheck-clj-kondo
;;   :ensure t
;;   :after clojure-mode)

;;; [ midje-mode ] -- Minor mode for running Midje tests in Emacs.

(use-package midje-mode
  :ensure t
  :defer t
  :after clojure-mode
  :commands (midje-mode))

;;; [ Emidje ] -- Test runner, report viewer and formatting tool for Midje within Emacs.

;; (use-package emidje
;;   :ensure t
;;   :defer t
;;   :commands (emidje-mode)
;;   :init (eval-after-load 'cider #'emidje-setup))

;;; [ kibit-helper ] -- Conveniently use the Kibit Leiningen plugin from Emacs.

;; (use-package kibit-helper
;;   :ensure t
;;   :defer t
;;   :commands (kibit kibit-current-file kibit-accept-proposed-change)
;;   :bind (:map clojure-mode-map
;;               ("C-x C-`" . kibit-accept-proposed-change)))

;;; [ cider-decompile ] -- decompilation extension for cider.

;; (use-package cider-decompile
;;   :ensure t
;;   :defer t
;;   :commands (cider-decompile-func cider-decompile-ns-func))

;;; [ cider-spy ] -- Spy on CIDER to get Info.

;; (use-package cider-spy
;;   :ensure t
;;   :defer t)

;;; [ ob-clojure ] -- org-babel support for Clojure

(use-package ob-clojure
  :defer t
  :after clojure-mode
  :commands (org-babel-execute:clojure)
  :init (setq org-babel-clojure-backend 'cider)
  :config
  (add-to-list 'org-babel-load-languages '(clojure . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))

  ;; whether check Org-mode buffer's (ns ) declarations.
  ;; (setq cider-auto-track-ns-form-changes t)

  ;; let `ob-clojure' babel src blocks allow evaluation.
  (add-to-list 'org-babel-default-header-args:clojure
               '(:eval . "yes"))
  (add-to-list 'org-babel-default-header-args:clojure
               '(:noweb . "yes"))
  ;; caused tangled code wrapped in `clojure.pp/print'.
  ;; (add-to-list 'org-babel-default-header-args:clojure
  ;;              '(:results . "pp"))

  ;; No timeout when executing calls on Cider via nrepl
  (setq org-babel-clojure-sync-nrepl-timeout 30)
  (add-to-list 'org-babel-default-header-args:clojure ; for Clojure `dotimes' etc.
               '(:show-process . "no"))

  (defun ob-clojure-specify-session ()
    "Specify ob-clojure header argument :session.
With value selected from a list of available sessions."
    (interactive)
    (let ((info (org-babel-get-src-block-info)))
      (when (and (string= (car info) "clojure")
                 ;; only when :session is not specified yet.
                 (string= (cdr (assq :session (nth 2 info))) "none"))
        (org-babel-insert-header-arg
         "session"
         (format "\"%s\""
                 (completing-read
                  "Choose :session for ob-clojure: "
                  (mapcar (lambda (pair)
                            (buffer-name (car (cdr pair))))
                          (let ((sesman-system 'CIDER))
                            (sesman--all-system-sessions sesman-system 'sort)))))))))

  (define-key org-babel-map (kbd "M-j") 'ob-clojure-specify-session))

;;; [ ob-clojurescript ] -- org-babel support for ClojureScript

(use-package ob-clojurescript
  :ensure t
  :defer t
  :commands (org-babel-execute:clojurescript)
  :config
  (add-to-list 'org-babel-load-languages '(clojurescript . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

;;; [ typed-clojure-mode ] -- Typed Clojure minor mode for Emacs.

;; (use-package typed-clojure-mode
;;   :ensure t
;;   :defer t
;;   :init (add-hook 'clojure-mode-hook 'typed-clojure-mode))

;;; [ Java Docs ]

;;; `helm-dash' to search Java docs.

;;; [ helm-clojuredocs ] -- Searching for help in clojurdocs.org with Helm.

(use-package helm-clojuredocs
  :ensure t
  :after cider
  :bind (:map cider-doc-map ("M-d" . helm-clojuredocs)))

;;; [ elein ] -- running Leiningen commands from Emacs.

(use-package elein
  :ensure t
  :defer t
  :config
  (defun elein-lein-try ()
    (interactive)
    (with-current-buffer "*scratch*"
      (setq-local inferior-lisp-program
                  (concat "lein try "
                          (read-string "dependencies: " "org.clojure/clojure 1.9.0")))
      (command-execute 'inferior-lisp))
    (rename-buffer "*elein-lein-try*")))

;;; [ clomacs ] -- Clomacs simplifies call Clojure code from Emacs lisp.

(use-package clomacs
  :ensure t
  :defer t)

;;; [ parseclj ] -- EDN reader and Clojure Parser for Emacs Lisp

(use-package parseclj
  :ensure t
  :defer t)

;;; [ cljsbuild-mode ] -- A minor mode for the ClojureScript 'lein cljsbuild' command.

(use-package cljsbuild-mode
  :ensure t
  :defer t)

;;; [ 4clojure ] -- Open and evaluate 4clojure.com questions in Emacs.

(use-package 4clojure
  :ensure t
  :defer t
  :config
  (defadvice 4clojure-open-question (around 4clojure-open-question-around)
    "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
    ad-do-it
    (unless cider-current-clojure-buffer
      (cider-jack-in)))

  (defun my/4clojure-check-and-proceed ()
    "Check the answer and show the next question if it worked."
    (interactive)
    (let ((result (4clojure-check-answers)))
      (unless (string-match "failed." result)
        (4clojure-next-question))))
  (define-key clojure-mode-map (kbd "C-c C-c") 'my/4clojure-check-and-proceed))

;;; [ YeSQL Ghosts ] -- Display ghostly YeSQL defqueries inline, in Emacs.

;; (use-package yesql-ghosts
;;   :ensure t
;;   :defer t
;;   :init (setq yesql-ghosts-show-ghosts-automatically t
;;               yesql-ghosts-show-descriptions t)
;;   :config (add-hook 'cider-mode-hook 'yesql-ghosts-auto-show-ghosts))

;;; [ HugSQL Ghosts ] -- Display ghostly HugSQL defqueries inline, in Emacs.

;; (use-package hugsql-ghosts
;;   :ensure t
;;   :defer t
;;   :init (setq hugsql-ghosts-newline-before-docstrings t)
;;   :config (add-hook 'cider-mode-hook 'hugsql-ghosts-install-hook))

(with-eval-after-load 'org
  (add-to-list 'org-default-properties "clojars")
  (add-to-list 'org-default-properties "Maven"))



(provide 'init-prog-lang-clojure)

;;; init-prog-lang-clojure.el ends here
