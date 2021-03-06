;;; init-prog-lang-elixir.el --- init for Elixir
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ elixir-mode ] -- Emacs major mode for Elixir

(use-package elixir-mode
  :ensure t
  :config
  ;; if you use smartparens you can piggyback on some of its functionality for
  ;; dealing with Ruby's do .. end blocks. A sample configuration would be:
  (sp-with-modes '(elixir-mode)
                 (sp-local-pair "fn" "end"
                                :when '(("SPC" "RET"))
                                :actions '(insert navigate))
                 (sp-local-pair "do" "end"
                                :when '(("SPC" "RET"))
                                :post-handlers '(sp-ruby-def-post-handler)
                                :actions '(insert navigate))))


;;; [ alchemist ] -- Elixir Tooling Integration into Emacs

(use-package alchemist
  :ensure t
  :init
  (defun my/alchemist-company-setup ()
    (my-company-add-backend-locally 'alchemist-company))
  (add-hook 'elixir-mode-hook #'my/alchemist-company-setup)

  :config
  (setq alchemist-key-command-prefix (kbd "C-c ,")) ; default: (kbd "C-c a")
  ;; run the whole test suite with `alchemist-mix-test' after saving a buffer.
  (setq alchemist-hooks-test-on-save nil))


;;; [ ob-elixir ]

(use-package ob-elixir
  :ensure t
  :defer t
  :commands (org-babel-execute:elixir)
  :config
  (add-to-list 'org-babel-load-languages '(elixir . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("elixir" . "ex")))


(provide 'init-prog-lang-elixir)

;;; init-prog-lang-elixir.el ends here
