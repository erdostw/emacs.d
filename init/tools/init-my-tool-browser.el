;;; init-my-tool-browser.el --- init for Browser
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; global keybindings

(unless (boundp 'browser-prefix)
  (define-prefix-command 'browser-prefix))
(define-key my-tools-prefix (kbd "b") 'browser-prefix)


;;; [ browse-url ] -- default browser function

;; system default browser: (`browser-url-browser-function')
;; - `browse-url-generic'
;; - `browse-url-default-browser'
;; - `browse-url-chrome'
;; - `browse-url-firefox'
;; - `browse-url-conkeror'
;; - `eww-browse-url' (EWW)
;; - `xwidget-webkit-browse-url'

(setq browse-url-browser-function 'browse-url-chrome)


;;; custom browser in specific case

(cl-defun my-generic-browser (url cmd-name &rest args)
  "Browse URL with NAME browser."
  (let ((proc (concat cmd-name " " url)))
    (message "Starting %s..." cmd-name)
    (apply 'start-process proc nil cmd-name
           (append args (list url)))
    (set-process-sentinel
     (get-process proc)
     (lambda (process event)
       (when (string= event "finished\n")
         (message "%s process %s" process event))))))

(defun browse-url-uzbl (url &optional _ignore)
  "Browse URL with uzbl browser."
  (interactive "sURL: ")
  (my-generic-browser url "uzbl-browser")
  )

(defun browse-url-luakit (url &optional _ignore)
  "Browse URL with Luakit browser."
  (interactive "sURL: ")
  (my-generic-browser url "luakit")
  )


;;; [ EWW ] -- The Emacs Web Wowser

(use-package eww
  :ensure t
  :config
  ;; set to "internal" Emacs Web Wowser
  ;; (setq browse-url-browser-function 'eww-browse-url)

  (setq eww-bookmarks-directory "~/.emacs.d/eww/bookmarks/"
        eww-download-directory "~/Downloads/"
        eww-form-checkbox-symbol "[ ]"
        eww-form-checkbox-selected-symbol "[X]"
        eww-header-line-format "%t: %u"   ; title: url.
        ;; - DuckDuckGo :: "https://duckduckgo.com/html/?q="
        ;; - Google :: "http://www.google.com/search?q=%s"
        ;; - Bing :: "http://bing.com/search?q="
        ;; search engine
        eww-search-prefix "https://www.google.com/search?q=%s"
        ;; eww-use-external-browser-for-content-type "\\`\\(video/\\|audio/\\|application/ogg\\)"
        )

  ;; faces
  (set-face-attribute 'eww-form-checkbox nil
                      :box '(:color "cyan" :line-width 2 :style 'released-button)
                      :foreground "gray" :background "black"
                      )

  ;; keybindings
  (define-key eww-mode-map (kbd "o") 'eww) ; prompt for a URL.
  
  (define-key eww-mode-map (kbd "f") 'eww-follow-link)
  (define-key eww-mode-map (kbd "d") 'eww-download)
  
  (define-key eww-mode-map (kbd "C-i") 'eww-back-url)
  (define-key eww-mode-map (kbd "C-o") 'eww-forward-url)
  (define-key eww-mode-map (kbd "r") 'eww-reload)
  
  (define-key eww-mode-map (kbd "<C-tab>") 'eww-buffer-select) ; 'eww-buffer-show, 'eww-list-buffers
  ;; (define-key eww-mode-map (kbd "<C-tab>") 'eww-buffer-show-next)
  ;; (define-key eww-mode-map (kbd "<C-S-iso-lefttab>") 'eww-buffer-show-previous)
  
  (define-key eww-mode-map (kbd "h") 'eww-history-browse) ; 'eww-list-histories
  
  (define-key eww-mode-map (kbd "b") 'eww-list-bookmarks)
  (define-key eww-mode-map (kbd "B") 'eww-add-bookmark)
  (define-key eww-mode-map (kbd "M-n") nil)
  (define-key eww-mode-map (kbd "M-p") nil)
  
  (define-key eww-mode-map (kbd "&") 'eww-browse-with-external-browser)
  
  (define-key eww-mode-map (kbd "v") 'eww-view-source)
  (define-key eww-mode-map (kbd "H") 'eww-parse-headers)
  (define-key eww-mode-map (kbd "R") 'eww-readable)
  
  (define-key eww-mode-map (kbd "<enter>") 'eww-submit)

  ;; custom helper functions
  (defun eww-search (term)
    (interactive "sSearch terms: ")
    (eww-browse-url (concat "http://www.google.com/search?gbv=1&source=hp&hl=en&ie=ISO-8859-1&btnG=Google+Search&q=" term)))

  (defun eww-wiki (text)
    "Function used to search wikipedia for the given text."
    (interactive (list (read-string "Wiki for: ")))
    (eww (format "https://en.m.wikipedia.org/wiki/Special:Search?search=%s"
                 (url-encode-url text))))

  (define-key eww-mode-map (kbd "s") 'eww-search)
  (define-key eww-mode-map (kbd "w") 'eww-wiki)
  )


;;; [ w3m ]

(use-package w3m
  :ensure t
  :commands w3m-goto-url w3m-search
  :config
  ;; (setq browse-url-browser-function 'w3m-browse-url)
  
  (setq w3m-coding-system 'utf-8
        w3m-file-coding-system 'utf-8
        w3m-file-name-coding-system 'utf-8
        w3m-input-coding-system 'utf-8
        w3m-output-coding-system 'utf-8
        w3m-terminal-coding-system 'utf-8)
  
  (setq w3m-use-cookies t)

  (define-key w3m-mode-map (kbd "&") 'w3m-view-url-with-external-browser)
  
  ;; setup keybindings
  (setq w3m-mode-map (make-sparse-keymap))

  (define-key w3m-mode-map (kbd "RET") 'w3m-view-this-url)
  (define-key w3m-mode-map (kbd "q") 'bury-buffer)
  (define-key w3m-mode-map [f5] 'w3m-reload-this-page)
  (define-key w3m-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
  (define-key w3m-mode-map (kbd "M-<left>") 'w3m-view-previous-page)
  (define-key w3m-mode-map (kbd "M-<right>") 'w3m-view-next-page)
  (define-key w3m-mode-map (kbd "M-.") 'w3m-haddock-find-tag)

  (define-key w3m-mode-map (kbd "<mouse-1>") 'w3m-maybe-url)
  
  (defun w3m-maybe-url ()
    (interactive)
    (if (or (equal '(w3m-anchor) (get-text-property (point) 'face))
            (equal '(w3m-arrived-anchor) (get-text-property (point) 'face)))
        (w3m-view-this-url)))
  )


;;; [ xwidget-webkit ]

(define-key browser-prefix (kbd "C-b") 'xwidget-webkit-browse-url)


;;; global keybindings

(if (featurep 'eww)
    (progn
      (define-key browser-prefix (kbd "o") 'eww)
      (define-key browser-prefix (kbd "w") 'eww-wiki)
      (define-key browser-prefix (kbd "s") 'eww-search)
      (define-key browser-prefix (kbd "f") 'eww-follow-link)
      )    
  (progn
    (define-key browser-prefix (kbd "f") 'browse-url-at-point)
    (define-key browser-prefix (kbd "l") 'w3m-goto-url)
    (define-key browser-prefix (kbd "f") 'w3m-search)
    )
  )


;;; [ ace-link ] -- easier link selection

;; (use-package ace-link
;;   :ensure t
;;   :config
;;   (ace-link-setup-default))


;;; [ conkeror-minor-mode ] -- mode for editing conkeror javascript files.

(use-package conkeror-minor-mode
  :ensure t
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
              (when (string= ".conkerorrc" (buffer-name))
                (conkeror-minor-mode 1))
              (when (string-match "conkeror" (buffer-file-name))
                (conkeror-minor-mode 1))))
  )


(provide 'init-my-tool-browser)

;;; init-my-tool-browser.el ends here
