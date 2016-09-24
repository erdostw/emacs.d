;;; init-ivy.el --- init for Ivy-mode
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ ivy ]

(use-package ivy
  :ensure t
  :init
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  
  :config
  ;; ivy-mode
  (setq ivy-use-virtual-buffers t ; treat recentf, bookmarks as virtual buffers.
        ivy-virtual-abbreviate 'full ; use 'full to fix bookmarks uniquify issue.
        ivy-height 5
        ivy-fixed-height-minibuffer nil
        ivy-display-style 'fancy
        ivy-count-format "(%d/%d) "
        ivy-initial-inputs-alist nil ; remove initial ^ input.
        ivy-extra-directories '("./" "../") ; remove . and .. directory.
        ivy-wrap nil
        )

  ;; use fuzzy search as default matcher
  ;; (setq ivy-re-builders-alist
  ;;       '((ivy-switch-buffer . ivy--regex-plus)
  ;;         (t . ivy--regexp-fuzzy)))

  (set-face-attribute 'ivy-confirm-face nil
                      :inherit nil
                      :foreground "black" :background "khaki"
                      :weight 'bold)
  (set-face-attribute 'ivy-current-match nil
                      :inherit nil
                      ;; :foreground "white" :background "#004A5D"
                      ;; :weight 'normal :box nil
                      ;; Sci-Fi style
                      :foreground "white" :background "#004A5D"
                      :box '(:color "cyan" :line-width -1)
                      )
  (set-face-attribute 'ivy-match-required-face nil
                      :inherit 'minibuffer-prompt
                      :foreground "dark red" :background nil
                      :weight 'bold :box nil
                      )
  ;; the string between matches
  (set-face-attribute 'ivy-minibuffer-match-face-1 nil
                      :inherit nil
                      :foreground nil :background nil
                      :weight 'normal :box nil
                      )
  ;; first match part.
  (set-face-attribute 'ivy-minibuffer-match-face-2 nil
                      :inherit 'ivy-minibuffer-match-face-1
                      :foreground "green" :background nil
                      :weight 'normal :box nil :underline t
                      )
  ;; second match part.
  (set-face-attribute 'ivy-minibuffer-match-face-3 nil
                      :inherit 'ivy-minibuffer-match-face-1
                      :foreground "orange" :background nil
                      :weight 'normal :box nil :underline t
                      )
  (set-face-attribute 'ivy-minibuffer-match-face-4 nil
                      :inherit 'ivy-minibuffer-match-face-1
                      :foreground "dodger blue" :background nil
                      :weight 'normal :box nil :underline t
                      )
  
  ;; Custom Functions

  ;; {Bookmarks}
  (defun ivy-bookmark-goto ()
    "Open ANY bookmark"
    (interactive)
    (let (bookmarks filename)
      ;; load bookmarks
      (unless (featurep 'bookmark)
        (require 'bookmark))
      (bookmark-maybe-load-default-file)
      (setq bookmarks (and (boundp 'bookmark-alist) bookmark-alist))

      ;; do the real thing
      (ivy-read "bookmarks:"
                (delq nil (mapcar (lambda (bookmark)
                                    (let (key)
                                      (setq key (car bookmark))
                                      (cons key bookmark)))
                                  bookmarks))
                :action (lambda (bookmark)
                          (bookmark-jump bookmark)))
      ))

  (global-set-key [remap bookmark-jump] 'ivy-bookmark-goto)
  
  (ivy-mode 1)
  )


;;; [ swiper ]

(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-c u") 'swiper-all)
  )


;;; [ counsel ]

(use-package counsel
  :ensure t
  :config
  ;; for big size buffer have long swiper startup time. This command will use
  ;; swiper for small buffers, and counsel-grep for large buffers.
  (global-set-key (kbd "C-s") 'counsel-grep-or-swiper)
  
  (global-set-key [remap execute-extended-command] 'counsel-M-x) ; [M-x]
  (global-set-key [remap describe-variable] 'counsel-describe-variable) ; [C-h v]
  (global-set-key [remap describe-function] 'counsel-describe-function) ; [C-h f]
  (global-set-key [remap describe-bindings] 'counsel-descbinds) ; [C-h b]
  (global-set-key [remap info-lookup-symbol] 'counsel-info-lookup-symbol) ; [C-h S]
  (global-set-key [remap menu-bar-open] 'counsel-tmm) ; [F10] text menu access
  (global-set-key (kbd "C-x c p") 'counsel-list-processes) ; [C-x c p]
  (global-set-key (kbd "C-x RET v") 'counsel-set-variable) ; [C-x RET v]
  (global-set-key (kbd "C-x RET u") 'counsel-unicode-char) ; [C-x RET u]
  ;; (setq ivy-switch-buffer-show-info '("%s" "buffer-name"))
  (global-set-key [remap switch-to-buffer] 'ivy-switch-buffer) ; [C-x b]
  ;; (global-set-key (kbd "C-x C-b") 'ivy-recentf)
  (global-set-key [remap find-file] 'counsel-find-file) ; [C-x C-f]
  (global-set-key (kbd "M-t") 'counsel-git) ; [M-t]
  (global-set-key (kbd "C-c v g g") 'counsel-git-grep)
  (unless (boundp 'my-search-prefix)
    (define-prefix-command 'my-search-prefix))
  (global-set-key (kbd "C-c s") 'my-search-prefix)
  (define-key my-search-prefix (kbd "g") 'counsel-grep)
  (global-set-key [remap grep] 'counsel-grep) ; [C-s g]
  (define-key my-search-prefix (kbd "G") 'counsel-ag) ; [C-u] prompt for dir support
  (setq counsel-yank-pop-truncate t)
  (global-set-key [remap yank-pop] 'counsel-yank-pop) ; [M-y]
  (define-key ivy-minibuffer-map (kbd "M-y") 'ivy-next-line) ; [M-y] repeatly to next item.
  (global-set-key [remap imenu] 'counsel-imenu)
  (global-set-key (kbd "C-x j") 'counsel-imenu)
  ;; (global-set-key [remap org-set-tags-command] 'counsel-org-tag) ; [C-c C-q]
  (global-set-key [remap org-agenda-set-tags] 'counsel-org-tag-agenda) ; [:]
  (global-set-key [remap load-library] 'counsel-load-library)
  (global-set-key [remap load-theme] 'counsel-load-theme)
  (global-set-key [remap locate] 'counsel-locate)
  (global-set-key (kbd "C-c #") 'counsel-linux-app)
  )


;;; [ counsel-projectile ] -- Ivy integration for Projectile.

;;; Usage:
;;
;; - [M-x counsel-projectile]
;; - [M-o] for actions

;; (use-package counsel-projectile
;;   :ensure t
;;   :commands counsel-projectile
;;   :config
;;   (define-key projectile-command-map (kbd "p") 'counsel-projectile)
;;   )


(provide 'init-ivy)

;;; init-ivy.el ends here
