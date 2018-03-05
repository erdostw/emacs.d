;;; init-tool-blog.el --- init for Blog
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


(unless (boundp 'blog-map)
  (define-prefix-command 'blog-map))
(define-key tools-prefix (kbd "l") 'blog-map)


;;; [ blog-admin ] -- Write blog in emacs with many backends: hexo/org-page/nikola

(use-package blog-admin
  :ensure t
  :defer t
  :bind (:map blog-map
              ("l" . blog-admin-start))
  :config
  ;; open post after create new post
  (add-hook 'blog-admin-backend-after-new-post-hook 'find-file)
  ;; backend: org-page
  (setq blog-admin-backend-type 'org-page
        blog-admin-backend-path "~/Org/Blog/org-page"
        blog-admin-backend-new-post-in-drafts t
        blog-admin-backend-new-post-with-same-name-dir t
        blog-admin-backend-org-page-drafts "_drafts" ; directory to save draft
        )
  )



(require 'init-tool-blog-org)


(provide 'init-tool-blog)

;;; init-tool-blog.el ends here