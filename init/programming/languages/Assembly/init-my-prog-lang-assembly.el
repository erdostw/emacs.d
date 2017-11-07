;;; init-my-prog-lang-assembly.el --- init for Assembly languages
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ asm-mode ]

(use-package asm-mode
  :ensure t
  :defer t
  :config
  (defun my-asm-mode-settings ()
    ;; you can use `comment-dwim' (M-;) for this kind of behaviour anyway
    (local-unset-key (vector asm-comment-char))
    ;; asm-mode sets it locally to nil, to "stay closer to the old TAB behaviour".
    (setq-local tab-always-indent (default-value 'tab-always-indent))
    )

  (add-hook 'asm-mode-hook #'my-asm-mode-settings)
  )


;;; [ nasm-mode ] -- NASM x86 assembly major mode.

(use-package nasm-mode
  :ensure t
  :defer t)


;;; [ fasm-mode ]


;;; [ iasm-mode ] -- interactive assembly major mode.

(use-package iasm-mode
  :ensure t
  :defer t
  :config
  (define-key iasm-mode-map (kbd "C-c C-d") 'iasm-disasm)
  (define-key iasm-mode-map (kbd "C-c d") 'iasm-goto-disasm-buffer)
  (define-key iasm-mode-map (kbd "C-c C-l") 'iasm-ldd)
  (define-key iasm-mode-map (kbd "C-c l") 'iasm-disasm-link-buffer)
  )


;;; [ gas-mode ]


;;; [ haxor-mode ] -- Major mode for editing Haxor Assembly Files.

(use-package haxor-mode
  :ensure t
  :defer t
  :mode ("\\.hax\\'" . haxor-mode)
  )


;;; [ mips-mode ] -- An Emacs major mode for MIPS assembly code.

(use-package mips-mode
  :ensure t
  :defer t
  :mode "\\.mips$"
  )


;;; [ llvm-mode ] -- Major mode for the LLVM assembler language.

(use-package llvm-mode
  :ensure t
  :defer t)


;;; [ x86-lookup ] -- jump to x86 instruction documentation.

(use-package x86-lookup
  :ensure t
  :defer t
  :init
  (define-key asm-mode-map (kbd "C-h d d") #'x86-lookup)
  :config
  (setq x86-lookup-pdf (concat
                        user-emacs-directory
                        "documentations/Assembly/NASM/"
                        "Intel 64 and IA-32 Architectures Software Developers Manuals: combined volumes 2A, 2B, 2C, and 2D: Instruction set reference, A-Z.pdf"))
  (setq x86-lookup-browse-pdf-function 'x86-lookup-browse-pdf-okular)
  )


;;; [ inferior-spim ] -- An emacs inferior mode for spim.

(use-package inferior-spim
  :ensure t
  :defer t
  :init
  (define-key asm-mode-map (kbd "C-`") 'inferior-run-spim)
  (define-key asm-mode-map (kbd "C-c C-z") 'inferior-switch-to-spim)
  (define-key asm-mode-map (kbd "C-c C-b") 'inferior-spim-send-buffer)
  (define-key asm-mode-map (kbd "C-c C-l") 'inferier-spim-load-file)
  (define-key asm-mode-map (kbd "C-c i") 'inferior-spim-send-reinitialize)
  (define-key asm-mode-map (kbd "C-c r") 'inferior-spim-send-run)
  )


(provide 'init-my-prog-lang-assembly)

;;; init-my-prog-lang-assembly.el ends here
