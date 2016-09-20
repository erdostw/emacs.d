;;; init-my-prog-lang-python.el --- init Python Programming Language Environment
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ python-mode ] --- Python's flying circus support for Emacs

;; (use-package python-mode
;;   :ensure t
;;   :config
;;   (setq-default python-indent-offset 2
;;                 python-indent-guess-indent-offset t
;;                 ;; "python", "ipython", "bpython"
;;                 ;; python-shell-interpreter "python"
;;                 ;; python-shell-interpreter-args "-i"
;;                 ;; python-shell-interpreter-interactive-arg "-i"
;;                 python-shell-virtualenv-path "~/.virtualenvs/python3/"
;;                 ;; python-ffap-setup-code
;;                 ;; python-ffap-string-code
;;                 python-skeleton-autoinsert t
;;                 )
;;
;;   ;; temporary solution to fix python-mode completion suspend for long time.
;;   ;; `completion-at-point-functions': (python-completion-complete-at-point t)
;;   (dolist (hook '(python-mode-hook
;;                   inferior-python-mode-hook
;;                   ))
;;     (add-hook hook '(lambda ()
;;                       (setq-local completion-at-point-functions nil))))
;;   )


;;; [ elpy ] -- Emacs Python Development Environment.

(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setq elpy-rpc-backend "jedi")

  (setq python-indent-offset 2
        python-indent 2)
  
  (add-hook 'elpy-mode-hook
            (lambda ()
              (my-company-add-backend-locally 'elpy-company-backend)
              
              (define-key python-mode-map (kbd "C-h d d") 'elpy-doc)
              (define-key python-mode-map (kbd "M-,") 'pop-tag-mark)
              (define-key python-mode-map (kbd "C-c C-s") 'run-python)
              (define-key elpy-mode-map (kbd "C-c C-s") 'run-python)

              ;; disable some modes
              (highlight-indentation-mode -1)
              ;; (flymake-mode-off)
              ))
  )


;;; [ Inferior Python ]

;; - [C-c C-l] :: `python-shell-send-file'
;; - [C-c C-r] :: `python-shell-send-region'
;; - [C-c C-c] :: `python-shell-send-buffer'
;; - [C-M-x]   :: `python-shell-send-defun'
;; - `python-shell-send-string'

(defun my-inferior-python ()
  "My function to start or switch to inferior-python process buffer `PROCESS-BUFFER-NAME'."
  (interactive)
  (if (get-buffer-process "*Python*")
      ;; the inferior Python process exist
      (switch-to-buffer "*Python*")
    ;; create a new inferior Python process
    (run-python "python")
    ;; kill old process
    ;; (kill-process (get-buffer-process (or process-buffer-name "*Python*"))
    )
  )

(define-key my-prog-inferior-map (kbd "p") 'my-inferior-python) ; 'run-python

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c C-s") 'run-python)
            ))


;;; [ pyenv-mode ] -- Python virtual environment interface

;;; Usage:
;;
;; 1. [M-x pyenv-mode-set] :: specify pyenv python version.
;; 2. [M-x run-python] :: run inferior python.
;; 3. [M-x pyenv-mode-unset] :: unset

;; (use-package pyenv-mode
;;   :ensure t
;;   :config
;;   ;; this pyven-mode is global. [C-c C-u] [C-c C-s]
;;   ;; (add-hook 'python-mode-hook 'pyenv-mode)
;;
;;   ;; projectile integration
;;   (defun projectile-pyenv-mode-set ()
;;     "Set pyenv version matching project name.
;;   Version must be already installed."
;;     (pyenv-mode-set (projectile-project-name)))
;;  
;;   (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)
;;   )


;;; [ pyvenv ] -- Python virtual environment interface for Emacs.

;;; This is a simple global minor mode which will replicate the changes done by
;;; virtualenv activation inside Emacs.

;;; Usage:
;;
;; - `pyvenv-activate'
;;
;;   queries the user for a virtual environment directory to activate.
;;
;; - `pyvenv-workon'
;;
;;    queries for a virtual environment in $WORKON_HOME (from
;;    virtualenvwrapper.sh).
;;
;; - `pyvenv-mode-line-indicator'
;;
;;   an indicator for mode-line.

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-workon "python3"))


;;; [ pythonic ]

;; - `pythonic-activate' :: active Python virtualenv.

;; (use-package pythonic
;;   :ensure t
;;   :config
;;   (pythonic-activate "~/.virtualenvs/python3")
;;   )


;;; [ virtualenv ]


;;; [ virtualenvwrapper ]


;;; [ anaconda-mode ]

;; (use-package anaconda-mode
;;   :ensure t
;;   :config
;;   ;; enable anaconda-mode in python-mode.
;;   (add-hook 'python-mode-hook 'anaconda-mode)
;;   (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;;   )


;;; [ company-anaconda ]

;; (use-package company-anaconda
;;   :ensure t
;;   :config
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (my-company-add-backend-locally 'company-anaconda)
;;               ))
;;   )


;;; [ conda ] -- work with your conda environments.

;; (use-package conda
;;   :ensure t
;;   :config
;;   ;; (setq conda-anaconda-home (concat (getenv "HOME") "/.anaconda3"))
;;   ;; (conda-env-initialize-interactive-shells)
;;   (conda-env-initialize-eshell)
;;   ;; (conda-env-autoactivate-mode t) ; NOTE: this is annoying.
;;   )


;;; [ IPython ]



;;; [ Emacs IPython Notebook (EIN) ] -- IPython notebook client in Emacs

(use-package ein
  :ensure t
  :config
  (setq ein:use-auto-complete t
        ;; ein:use-auto-complete-superpack nil
        ein:use-smartrep nil
        ein:load-dev nil
        )
  )



(provide 'init-my-prog-lang-python)

;;; init-my-prog-lang-python.el ends here
