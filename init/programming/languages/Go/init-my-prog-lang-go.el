;;; init-my-prog-lang-go.el --- init Go language Emacs settings

;;; Commentary:


;;; Code:

;;; [ go-mode ]

(use-package go-mode
  :ensure t
  :config
  ;; (setq go-command "go"
  ;;       gofmt-command "gofmt"
  ;;       gofmt-show-errors 'buffer         ; 'buffer, 'echo, nil
  ;;       godef-command "godef"
  ;;       godoc-command "go doc"
  ;;       godoc-at-point-function 'godoc-and-godef
  ;;       )

  (defun my-go-mode-settings ()
    ;; go-import [C-u] + [C-c C-a]
    ;; (local-set-key (kbd "C-c C-S-a") 'go-remove-unused-imports)
    ;; gofmt
    (local-set-key (kbd "C-c C-f") 'gofmt)
    ;; godoc -- `go doc [QUERY]`
    (local-set-key (kbd "C-h d d") 'godoc-at-point) ; `godoc', `godoc-at-point'
    ;; (local-set-key (kbd "C-c C-k") 'godoc)
    ;; godef
    ;; use `godef-jump' instead of `etags' etc tags jumping.
    (local-set-key (kbd "M-.") #'godef-jump)
    )
  
  (add-hook 'go-mode-hook #'my-go-mode-settings)
  
  (add-hook 'before-save-hook #'gofmt-before-save)
  )


;;; [ go-gopath ] -- guess GOPATH using gb and projectile.

(use-package go-gopath
  :ensure t
  :config
  (define-key go-mode-map (kbd "C-x C-e") #'go-gopath-set-gopath)
  )


;;; [ go-eldoc ]

(use-package go-eldoc
  :ensure t
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))


;;; [ gocode ] -- An autocompletion daemon for the Go programming language.


;;; [ go-complete ] -- Native Go completion for Emacs.

;; (use-package go-complete
;;   :ensure t
;;   :config
;;   (add-hook 'go-mode-hook
;;             '(lambda ()
;;                (add-hook (make-local-variable 'completion-at-point-functions)
;;                          'go-complete-at-point)))
;;   )


;;; [ go-autocomplete ]


;;; [ go-company ]


;;; [ company-go ]

(use-package company-go
  :ensure t
  :config
  (if (getenv "GOPATH")
      (load
       (concat (getenv "GOPATH")
               "/src/github.com/nsf/gocode/emacs-company/company-go.el"))
    (error "SHELL env $GOPATH not available, set it in your SHELL"))

  (setq company-go-show-annotation t
        company-go-begin-after-member-access t
        company-go-insert-arguments t
        )
  
  (add-hook 'go-mode-hook
            (lambda ()
              (my-company-add-backend-locally 'company-go)))
  )


;;; [ gorepl-mode ] -- Go REPL Interactive Development in top of Gore.

(use-package gorepl-mode
  :ensure t
  :config
  ;; default setup mapping (this will override `go-goto-map')
  ;; (add-hook 'go-mode-hook #'gorepl-mode)

  ;; custom mapping
  (define-key go-mode-map (kbd "C-c C-s") 'gorepl-run)
  (define-key go-mode-map (kbd "C-c C-z") 'gorepl-run)
  (define-key go-mode-map (kbd "C-c C-l") #'gorepl-run-load-current-file)
  (define-key go-mode-map (kbd "C-c C-e") #'gorepl-eval-region)
  (define-key go-mode-map (kbd "C-c C-r") #'gorepl-eval-line)
  )


;;; [ gore-mode ] -- Simple mode for gore, a command-line evaluator for golang.


;;; [ go-play ] -- Paste to play.golang.org


;;; [ go-playground ] -- Local Golang playground for short snippets.

(use-package go-playground
  :ensure t
  :config
  (setq go-playground-basedir "~/.go/src/playground")
  )


;;; [ go-playground-cli ]

;; (use-package go-playground-cli)


;;; [ go-errcheck ]

(use-package go-errcheck
  :ensure t)


;;; [ go-oracle ]

(load "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

(require 'go-oracle)


;;; [ go-guru ] -- Integration of the Go 'guru' analysis tool into Emacs.

(use-package go-guru
  :ensure t
  :config
  ;; (setq go-guru-scope)
  )


;;; [ gotest ] -- Launch GO unit tests


;;; [ govet ] -- linter/problem finder for the Go source code.


;;; [ go-projectile ] -- Projectile GOPATH.

(use-package go-projectile
  :ensure t)


;; [ ob-go ]

(use-package ob-go
  :ensure t)


(provide 'init-my-prog-lang-go)

;;; init-my-prog-lang-go.el ends here
