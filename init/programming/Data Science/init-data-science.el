;;; init-data-science.el --- init Emacs for Data Science

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------
;;; [ Emacs IPython Notebook (EIN) ] -- IPython notebook client in Emacs

;; (use-package ein
;;   :ensure t)

;;; [ ob-ipython ]

(use-package ob-ipython
  :ensure t
  :defer t
  :config
  ;; open ipython block block with `python-mode'
  ;; (add-to-list 'org-src-lang-modes '("ipython" . python))
  ;; use IJulia backend for IPython notebook
  ;; (add-to-list 'org-src-lang-modes '("ipython" . python))

  (add-to-list 'org-babel-load-languages '(ipython . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("ipython" . "ipynb"))
  
  (setq org-babel-default-header-args:ipython
        '((:session . nil)
          ;; (:dir . "data/images")
          (:exports . "both")
          ))

  ;; different kernels support
  (defun ob-ipython-kernel-get-kernels ()
    "Get available Jupyter kernels.
This can be useful for snippets to select kernel interactively."
    (let ((kernels (split-string
                    (shell-command-to-string
                     "jupyter-kernelspec list | sed '1d' | awk -F ' ' '{print $1}'"))))
      ;; (completing-read "Jupyter kernels: "
      ;;                  kernels)
      kernels
      )
    )

  ;; support ox-latex + minted.
  (add-to-list 'org-latex-minted-langs '(ipython "python"))
  )


;;; [ Apache Hadoop ]


;;; [ Apache Pig ]

(use-package pig-mode
  :ensure t
  :defer t)

;;; [ Apache Hive ]

(use-package hive
  :ensure t
  :defer t)


(provide 'init-data-science)

;;; init-data-science.el ends here