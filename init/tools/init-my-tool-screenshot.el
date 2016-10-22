;;; init-my-tool-screenshot.el --- init for Screenshot
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


;; prefix

(unless (boundp 'my-screenshot-map)
  (define-prefix-command 'my-screenshot-map))
(define-key my-tools-prefix (kbd "S") 'my-screenshot-map)


;;; [ screenshot.el ]

(use-package screenshot
  :ensure t
  :defer t
  :init
  (define-key my-screenshot-map (kbd "S") 'screenshot)
  (define-key my-screenshot-map (kbd "s") 'screenshot-take) ; `screenshot-take-delay'
  
  :config
  (setq screenshot-schemes
        '(
          ;; To local image directory
          ("local"
           :dir "~/Screenshots/")            ; Image repository directory
          ;; To current directory
          ("current-directory"          ; No need to modify
           :dir default-directory)
          ;; To remote ssh host
          ("remote-ssh"
           :dir "/tmp/"                 ; Temporary saved directory
           :ssh-dir "www.example.org:public_html/archive/" ; SSH path
           :url "http://www.example.org/archive/")  ; Host URL prefix
          ;; To EmacsWiki (need yaoddmuse.el)
          ("EmacsWiki"                 ; Emacs users' most familiar Oddmuse wiki
           :dir "~/.yaoddmuse/EmacsWiki/"  ; same as yaoddmuse-directory
           :yaoddmuse "EmacsWiki")         ; You can specify another Oddmuse Wiki
          ;; To local web server
          ("local-server"
           :dir "~/public_html/"           ; local server directory
           :url "http://127.0.0.1/")))     ; local server URL prefix

  (setq screenshot-default-scheme "local")

  (setq screenshot-take-delay 0.5)
  )


(provide 'init-my-tool-screenshot)

;;; init-my-tool-screenshot.el ends here
