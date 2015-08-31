;;; init-my-prog-lang-markdown.el --- init Emacs for Markdown
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ markdown-mode ]

;;; Usage:
;;
;; - [C-h m] :: check out major mode keybindings.
;; - [C-c C-t] :: header
;; - [C-c C-s] :: insert
;; - [C-c C-x] :: change header
;; - [C-c C-c] :: function
;; - [C-c C-a] :: insert links
;; - [C-c C-]] :: complete
;;
;; note: some keybindings work on text also can work on region.

(require 'markdown-mode)

;;; Faces
;; header text
(set-face-attribute 'markdown-header-face nil
                    :foreground "cyan"
                    :weight 'bold
                    ;; :box '(:color "cyan" :line-width 1)
                    :overline t
                    )
;; # header #
(set-face-attribute 'markdown-header-delimiter-face nil
                    :foreground "#444444"
                    ;; :box '(:color "cyan" :line-width 1)
                    )
;; header
;; ======
(set-face-attribute 'markdown-header-rule-face nil
                    :foreground "#444444"
                    )
;; header (1-6)
(set-face-attribute 'markdown-header-face-1 nil
                    :inherit 'markdown-header-face
                    :foreground "cyan"
                    :overline t)
(set-face-attribute 'markdown-header-face-2 nil
                    :inherit 'markdown-header-face-1
                    :foreground "deep pink")
(set-face-attribute 'markdown-header-face-3 nil
                    :inherit 'markdown-header-face-1
                    :foreground "green yellow")
(set-face-attribute 'markdown-header-face-4 nil
                    :inherit 'markdown-header-face-1
                    :foreground "yellow")
(set-face-attribute 'markdown-header-face-5 nil
                    :inherit 'markdown-header-face-1
                    :foreground "slate blue")
(set-face-attribute 'markdown-header-face-6 nil
                    :inherit 'markdown-header-face-1
                    :foreground "sky blue")
;; line break
(set-face-attribute 'markdown-line-break-face nil
                    :foreground "slate blue")
;; italic
(set-face-attribute 'markdown-italic-face nil
                    :slant 'italic
                    :foreground "white")
;; bold
(set-face-attribute 'markdown-bold-face nil
                    :weight 'bold
                    :foreground "white")
;; list
(set-face-attribute 'markdown-list-face nil
                    :foreground "red")
;; comment
(set-face-attribute 'markdown-comment-face nil
                    :foreground "dark gray")
;; link
(set-face-attribute 'markdown-link-face nil
                    :foreground "#888888"
                    :underline '(:color "dark cyan"))
(set-face-attribute 'markdown-url-face nil
                    :foreground "cyan")
(set-face-attribute 'markdown-link-title-face nil
                    :foreground "cyan")
(set-face-attribute 'markdown-missing-link-face nil
                    :foreground "#888888" :background "dark red"
                    :underline '(:color "dark cyan"))
;; meta-data
(set-face-attribute 'markdown-metadata-key-face nil
                    :foreground "slate blue")
(set-face-attribute 'markdown-metadata-value-face nil
                    :foreground "yellow")
;; footnote & reference
(set-face-attribute 'markdown-footnote-face nil
                    :foreground "light blue" :background "black")
(set-face-attribute 'markdown-reference-face nil
                    :foreground "green" :background "black")
;; block, quote, pre, code
(set-face-attribute 'markdown-pre-face nil
                    :foreground "cyan" :background "black")
;; programming language identifier
(set-face-attribute 'markdown-language-keyword-face nil
                    :foreground "cyan")
(set-face-attribute 'markdown-blockquote-face nil
                    :foreground "cyan" :background "black")
(set-face-attribute 'markdown-inline-code-face nil
                    :foreground "white" :background "dark cyan"
                    :box '(:color "cyan" :line-width -1))
(set-face-attribute 'markdown-math-face nil
                    :foreground "orange")



;;; for Stack Overflow {It's All Text} (Firefox Addon)
;; Integrate Emacs with Stack Exchange http://stackoverflow.com/a/10386560/789593
(add-to-list 'auto-mode-alist '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt" . markdown-mode))
;; Alternatively, if `as-external-alist' is defined—if M-x describe-variable RET
;; as-external-alist doesn't fail—it will probably override your
;; auto-mode-alist. It has a slightly different format (it's a list of pairs
;; instead of a list of cons cells) so this will work:
;; (add-to-list 'as-external-alist '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt" markdown-mode))


;;; [ markdown-preview-mode ]

;;; Makes use of markdown-mode, which already can transform markdown into html
;;; and websocket.el to deliver html to browser.

;;; Usage:
;;; - [M-x markdown-preview-mode] :: open preview in a browse.
;;;
;;; [M-x markdown-preview-mode] will open preview in a browser and will start
;;; markdown-mode if it's not yet running for current buffer. If you'v closed
;;; the preview window, you can start it over with [M-x
;;; markdown-preview-open-browser]. All websockets will be cleaned up on emacs
;;; termination. If you'd like to perform cleanup manually run [M-x
;;; markdown-preview-cleanup].

;; (require 'markdown-preview-mode)
(autoload 'markdown-preview-mode "markdown-preview-mode.el" nil t)

;; enable MultiMarkdown support
;; (setq markdown-command "multimarkdown")

;; custom css theme
(setq markdown-preview-style ""http://thomasf.github.io/solarized-css/solarized-dark.min.css"")

;; websocket.el port
;; (setq markdown-preview-port 7379)

;; (set-face-attribute 'markdown-pre-face nil
;;                     :inherit 'font-lock-constant-face
;;                     )

(define-key markdown-mode-map (kbd "C-c C-k") 'markdown-preview-mode)


;;; [ realtime-preview ] -- realtime preview markdown by EWW.

;;; Usage:
;;
;; 1. open markdown file
;; 2. [M-x realtime-preview]

;; (require 'realtime-preview)
;;
;; (add-hook 'markdown-mode-hook 'realtime-preview)



(provide 'init-my-prog-lang-markdown)

;;; init-my-prog-lang-markdown.el ends here
