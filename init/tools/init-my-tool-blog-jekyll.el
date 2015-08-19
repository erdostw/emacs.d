;;; init-my-tool-blog-jekyll.el --- init for Jekyll
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ jekyll.el ]

;;; Usage:
;;
;; commands usage workflow
;;
;; 1. create a new draft
;; 2. publish current draft in draft buffer
;; 3. build
;;
;; Here are the default key bindings:
;; C-x t l j D - Show all drafts
;; C-x t l j P - Show all posts
;; C-x t l j d - Create new draft
;; C-x t l j p - Publish current draft
;; C-x t l j b - Build
;;
;; To load them just do:
;; (jekyll-init-keybindings)

;; If mumamo is present (it's part of nxhtml) then a multi major mode is enabled
;; for the blog posts, so the YAML front matter will use yaml-mode and the
;; chunks between highlight tags also use their modes.
;;
;; Integrated support for ruby and javascript.
;;
;; You can add other modes for highlighting in your configuration.

;; (require 'jekyll)
;;
;; (setq jekyll-directory "~/Servers/Websites/Blogs/jekyll.github.io/"
;;       ;; jekyll-post-ext ".markdown"
;;       )

;; (setq jekyll-post-template "---
;; title: %s
;; ---
;;
;; ")

;; (require 'jekyll-mumamo)
;;; You can add other modes for highlighting in your configuration.
;;; Integrated support for ruby and javascript.
;; (add-to-list 'jekyll-modes-list '("erlang" 'erlang-mode))

;; (if (featurep 'jekyll)
;;     (progn
;;       (unless (boundp 'jekyll-map)
;;         (define-prefix-command 'jekyll-map))
;;       (define-key blog-map (kbd "j") 'jekyll-map)
;;      
;;       (define-key jekyll-map (kbd "d") 'jekyll-draft-post)
;;       (define-key jekyll-map (kbd "p") 'jekyll-publish-post)
;;       (define-key jekyll-map (kbd "P") (defun jekyll-posts-files ()
;;                                          (interactive)
;;                                          (find-file (concat jekyll-directory "_posts/"))))
;;       (define-key jekyll-map (kbd "D") (defun jekyll-drafts-files ()
;;                                          (interactive)
;;                                          (find-file (concat jekyll-directory "_drafts/"))))
;;       (define-key jekyll-map (kbd "b")
;;         (defun jekyll-build ()
;;           (interactive)
;;           (shell-command "jekyll build")))
;;       )
;;   )


;;; [ jekyll-modes ]

;;; Usage:
;;
;; - [jekyll-markdown-mode]
;; - [jekyll-html-mode]


;;; [ org-jekyll ] -- export jekyll blog posts from org-mode.

;; Extracts subtrees from your org-publish project files that have a :blog:
;; keyword and an :on: property with a timestamp, and exports them to a
;; subdirectory _posts of your project's publishing directory in the
;; year-month-day-title.html format that Jekyll expects. Properties are passed
;; over as yaml front-matter in the exported files. The title of the entry is
;; the title of the subtree.

;; (require 'org-jekyll)
;;
;; (setq org-jekyll-category nil
;;       org-jekyll-new-buffers nil
;;       org-jekyll-localize-dir nil
;;       org-jekyll-lang-subdirs nil)
;;
;;
;; (setq org-jekyll-publish-blog-dir "~/Servers/Websites/Blogs/org-publish-jekyll/")
;; (setq org-jekyll-publish-blog-image-dir (concat org-jekyll-publish-blog-dir "images"))
;;
;; (add-to-list 'org-publish-project-alist
;;              '("org-jekyll-blog"
;;                :base-directory "~/Org/Diary/Public"
;;                :recursive t
;;                :base-extension "org"
;;                :publishing-directory ,org-jekyll-publish-blog-dir
;;                ;; :exclude "^jekyll\\|"
;;                :site-root "https://stardiviner.github.io/"
;;                :jekyll-sanitize-permalinks t
;;                :publishing-function org-html-publish-to-html
;;                :section-numbers nil
;;                :headline-levels 4
;;                :table-of-contents t
;;                :auto-index nil
;;                :auto-preamble nil
;;                :body-only nil
;;                :auto-postamble nil
;;                ))
;;
;; (add-to-list 'org-publish-project-alist
;;              '("org-jekyll-image"
;;                :base-directory "~/Org/Diary/Public"
;;                :recursive t
;;                ;; :exclude "^publish"
;;                :base-extension "jpg\\|gif\\|png"
;;                :publishing-directory ,org-jekyll-publish-blog-image-dir
;;                :publishing-function org-html-publish-attachment))
;;
;; (add-to-list 'org-publish-project-alist
;;              '("org-jekyll" :components ("org-jekyll-blog"
;;                                    "org-jekyll-image")))
;;
;;
;; (unless (boundp 'org-jekyll-map)
;;   (define-prefix-command 'org-jekyll-map))
;; (define-key my-org-prefix-map (kbd "j") 'org-jekyll-map)
;;
;; (define-key org-jekyll-map (kbd "b") 'org-jekyll-export-blog)
;; (define-key org-jekyll-map (kbd "p") 'org-jekyll-export-project)
;; (define-key org-jekyll-map (kbd "e") 'org-jekyll-export-current-entry)



(provide 'init-my-tool-blog-jekyll)

;;; init-my-tool-blog-jekyll.el ends here
