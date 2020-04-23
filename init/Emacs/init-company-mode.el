;;; init-company-mode.el --- init company-mode
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Company Mode ]

(use-package company
  :ensure t
  :defer t
  :delight company-mode
  ;; disable `company-mode' in `org-mode' for performance.
  ;; :preface (setq company-global-modes '(not org-mode))
  :commands (global-company-mode)
  :init (global-company-mode 1)
  (setq company-minimum-prefix-length 3
        ;; decrease this delay when you can type code continuously fast.
        company-idle-delay 0.2
        company-tooltip-idle-delay 0 ; 0.5
        company-echo-delay 0 ; remove annoying blink
        company-auto-complete nil
        company-auto-complete-chars '(?\  ?\) ?. ?#) ; '(?_ ?\( ?w ?. ?\" ?$ ?\' ?/ ?| ?! ?#)
        ;; company-require-match 'company-explicit-action-p ; 'never
        company-tooltip-align-annotations t ; align annotations to the right tooltip border.
        company-tooltip-flip-when-above nil
        company-tooltip-limit 10 ; tooltip candidates max limit
        company-tooltip-minimum 3 ; minimum candidates height limit
        ;; company-tooltip-minimum-width 0 ; the minimum width of the tooltip's inner area
        company-tooltip-margin 1 ; width of margin columns to show around the tooltip
        company-selection-wrap-around t ; loop over candidates
        company-search-regexp-function #'company-search-flex-regexp)

  ;; `company-mode' frontend showing the selection as if it had been inserted.
  (setq-default company-frontends
                `(company-pseudo-tooltip-frontend
                  ;; ,(if (zerop company-tooltip-idle-delay)
                  ;;      'company-pseudo-tooltip-unless-just-one-frontend
                  ;;    'company-pseudo-tooltip-unless-just-one-frontend-with-delay)
                  ;; company-preview-if-just-one-frontend
                  company-echo-metadata-frontend
                  ;; company-preview-common-frontend
                  ))
  
  ;; company-tabnine: A company-mode backend for TabNine, the all-language autocompleter.
  (use-package company-tabnine
    :ensure t
    :config
    (add-to-list 'company-backends #'company-tabnine)
    ;; The free version of TabNine is good enough,
    ;; and below code is recommended that TabNine not always
    ;; prompt me to purchase a paid version in a large project.
    (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
      (let ((company-message-func (ad-get-arg 0)))
        (when (and company-message-func
                   (stringp (funcall company-message-func)))
          (unless (string-match "The free version of TabNine only indexes up to"
                                (funcall company-message-func))
            ad-do-it)))))

  (setq-default company-backends
                '((company-capf         ; `completion-at-point-functions'
                   :separate company-yasnippet
                   ;; :separate company-tempo  ; tempo: flexible template insertion
                   :separate company-keywords)
                  (company-dabbrev-code :with company-abbrev)
                  company-files))
  
  :config
  (defun my-company-add-backend-locally (backend)
    "Add a backend in my custom way.

(add-hook 'major-mode-hook
            #'(lambda (my-company-add-backend-locally 'company-backend)))"
    (unless (eq (if (listp (car company-backends))
                    (caar company-backends)
                  (car company-backends))
                backend)
      (setq-local company-backends
                  (cons
                   (list backend :with (car company-backends))
                   (cdr company-backends)))))

  ;; [ company-ispell ]
  ;; hide `company-ispell' echo message "Starting 'look' process".
  (use-package shut-up
    :ensure t
    :init (advice-add 'ispell-lookup-words :around
                      (lambda (orig &rest args)
                        (shut-up (apply orig args)))))
  
  ;; keybindings

  ;; manually start completion (don't globally set, conflict with auto-complete
  ;; in some modes which use auto-complete)
  ;;
  ;; (global-set-key (kbd "<tab>") 'company-indent-or-complete-common)
  ;; (define-key company-mode-map (kbd "<tab>") 'company-complete)
  ;; (define-key company-mode-map (kbd "TAB") 'company-complete)
  ;; (define-key company-mode-map [tab] 'company-complete)
  
  (define-key company-mode-map (kbd "C-M-i") 'company-complete)
  (define-key company-mode-map (kbd "M-<tab>") 'company-complete)

  ;; yasnippet
  ;; `yas-expand', `yas-expand-from-trigger-key'
  (define-key company-active-map [tab] 'yas-expand-from-trigger-key)

  ;; navigation
  (define-key company-active-map "\t" nil)
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "<tab>") nil)
  (define-key company-active-map (kbd "<S-tab>") nil)
  (define-key company-active-map (kbd "M-j") 'company-complete-selection)
  (define-key company-active-map (kbd "M-i") 'company-complete-common)
  (define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-l") 'company-show-location)
  ;; (setq company-search-regexp-function #regexp-quote)
  (define-key company-active-map (kbd "M-s") 'company-search-candidates)
  (define-key company-active-map (kbd "C-M-s") 'company-filter-candidates)
  ;; nested searching map.
  (define-key company-search-map (kbd "M-g") 'company-search-toggle-filtering)
  (define-key company-search-map (kbd "C-g") 'company-search-abort)
  (define-key company-search-map (kbd "M-s") 'company-search-repeat-forward)
  (define-key company-search-map (kbd "M-r") 'company-search-repeat-backward)
  (define-key company-search-map (kbd "M-n") 'company-search-repeat-forward)
  (define-key company-search-map (kbd "M-p") 'company-search-repeat-backward)
  (define-key company-search-map (kbd "M-o") 'company-search-kill-others)
  (define-key company-search-map (kbd "M-j") 'company-complete-selection)

  (defun company-new-line ()
    "insert a literal return new line."
    (interactive)
    ;; (company-abort)
    (company-cancel 'abort)
    (newline-and-indent))

  (define-key company-active-map [return] 'company-new-line)
  (define-key company-active-map "\r" 'company-new-line)

  (defun company-space ()
    "insert a literal return new line."
    (interactive)
    ;; (company-abort)
    (company-cancel 'abort)
    (insert " "))
  
  (define-key company-active-map (kbd "SPC") 'company-space)

  ;; [ company-yasnippet ]
  ;; make `company-yasnippet' work for prefix like `%link_to'.
  ;; (setq-default yas-key-syntaxes (list "w_" "w_." "w_.()"
  ;;                                      #'yas-try-key-from-whitespace))

  ;; [ company-abbrev / company-dabbrev ]
  (setq company-dabbrev-other-buffers t)

  ;; [ company-tempo ]

  ;; [ company-etags ]
  (setq company-etags-modes nil) ; disable `company-etags'
  ;; enable to offer completions in comment and strings.
  ;; (setq company-etags-everywhere t)

  ;; [ company-transformers ]
  ;; NOTE: disable customize `company-transformers' to fix python-mode company candidates
  ;; sorting.
  ;; (setq company-transformers '(company-sort-by-backend-importance
  ;;                              company-sort-prefer-same-case-prefix))
  
  ;; [ company-mode in minibuffer `M-:' ]
  (defun company-mode-minibuffer-setup ()
    "Setup company-mode in minibuffer."
    (company-mode 1)
    (setq-local company-tooltip-limit 4)
    (setq-local company-tooltip-minimum 1))
  (add-hook 'eval-expression-minibuffer-setup-hook 'company-mode-minibuffer-setup)
  
  (add-to-list 'display-buffer-alist
               '("^\\*company-documentation\\*" . (display-buffer-below-selected))))

;;; [ company-posframe ] -- Use a posframe as company candidate menu.

(use-package company-posframe
  :ensure t
  :init (company-posframe-mode)
  (setq company-posframe-show-indicator nil
        company-posframe-show-metadata nil
        company-posframe-quickhelp-show-header nil
        company-posframe-quickhelp-delay nil)
  :config
  (with-eval-after-load 'desktop
    (push '(company-posframe-mode . nil) desktop-minor-mode-table))
  (set-face-attribute 'company-posframe-quickhelp nil
                      :background (face-background 'company-tooltip)
                      :foreground (face-foreground 'company-tooltip)))

;;; [ company-box ] -- A company front-end with icons.

;; (use-package company-box
;;   ;; :ensure t
;;   ;; :quelpa (company-box :fetcher github :repo "stardiviner/company-box" :files (:defaults "images"))
;;   :load-path "~/Code/Emacs/company-box"
;;   :ensure all-the-icons
;;   :after (company all-the-icons)
;;   :defer t
;;   :commands (company-box-mode)
;;   :hook (company-mode . company-box-mode)
;;   :config
;;   (setq company-box-doc-delay 0.5
;;         ;; company-box-show-single-candidate t ; for still can use doc popup keybinding.
;;         ;; company-box-doc-enable nil ; disable auto `company-box-doc' timer.
;;         company-box-icons-image-size 25)
;;   ;; Use VSCode-like images
;;   (setq company-box-icons-alist 'company-box-icons-images))


(provide 'init-company-mode)

;;; init-company-mode.el ends here
