;;; init-tool-browser.el --- init for Browser
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; global keybindings

(unless (boundp 'browser-prefix)
  (define-prefix-command 'browser-prefix))
(define-key tools-prefix (kbd "b") 'browser-prefix)


;;; [ browse-url ] -- default browser function

;; system default browser: (`browser-url-browser-function')
;; - `browse-url-generic'
;; - `browse-url-default-browser'
;; - `browse-url-chrome'
;; - `browse-url-firefox'
;; - `browse-url-conkeror'
;; - `eww-browse-url' (EWW)
;; - `xwidget-webkit-browse-url'

(cl-case system-type
  ('gnu/linux
   (setq browse-url-chrome-program (executable-find "google-chrome-unstable"))
   (setq browse-url-firefox-program (executable-find "firefox")))
  ('darwin
   (setq browse-url-chrome-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
   (setq browse-url-firefox-program "/Applications/Firefox.app/Contents/MacOS/firefox")))

;;; set generic browser program for `browse-url-generic'
(setq browse-url-browser-function 'browse-url-chrome)
(setq browse-url-generic-program browse-url-chrome-program)

(require 'init-eww)
;; (require 'init-w3m)

;;; [ xwidget-webkit ]
(define-key browser-prefix (kbd "C-b") 'xwidget-webkit-browse-url)

;;; global keybindings

(if (featurep 'eww)
    (progn
      (define-key browser-prefix (kbd "b") 'eww)
      (define-key browser-prefix (kbd "o") 'eww-follow-link))
  (progn
    (define-key browser-prefix (kbd "o") 'browse-url-at-point)
    (define-key browser-prefix (kbd "g") 'w3m-goto-url)
    (define-key browser-prefix (kbd "s") 'w3m-search)))


;;; [ ace-link ] -- easier link selection with ace-mode on many buffer links.

(use-package ace-link ; [o]
  :ensure t
  :defer t
  :init (ace-link-setup-default)
  (with-eval-after-load 'mu4e
    (define-key mu4e-view-mode-map (kbd "C-c M-o") 'ace-link-mu4e))
  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c M-o") 'ace-link-org))
  (with-eval-after-load 'org-agenda
    (define-key org-agenda-mode-map (kbd "C-c M-o") 'ace-link-org-agenda)))

;;; [ counsel-ffdata ] -- Ivy interface to access your firefox bookmarks and history in Emacs.

(use-package counsel-ffdata
  :ensure t
  :defer t
  :commands (counsel-ffdata-firefox-bookmarks counsel-ffdata-firefox-history))

;;; [ helm-chrome ] -- Helm interface for Chrome bookmarks.

(use-package helm-chrome
  :ensure t
  :defer t
  :commands (helm-chrome))

;;; [ helm-chrome-control ] -- Control Chrome tabs with Helm (macOS only).

(use-package helm-chrome-control
  :ensure t
  :defer t
  :commands (helm-chrome-control))


(provide 'init-tool-browser)

;;; init-tool-browser.el ends here
