;;; init-prog-framework-web.el --- init Web framework settings for Emacs.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;;_ web-mode

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" . web-mode)
  :defer t
  :config
  ;; fontifications
  (setq web-mode-enable-element-tag-fontification t
        ;; web-mode-enable-element-content-fontification t
        ;; web-mode-enable-current-column-highlight t
        )

  ;;_. Associate a content type

  ;; web-mode.el can deal with many content types: html, xml, javascript, jsx,
  ;; json, css. This was needed to edit *.js.erb files for example: js files that
  ;; embed ruby blocks.
  ;;
  ;; Sometimes, web-mode.el can not guess the content type with the file
  ;; extension.  e.g. you want to associate *.api files with web-mode.
  ;;
  ;; (add-to-list 'auto-mode-alist '("\\.api\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("/some/react/path/*\\.js[x]?\\'" . web-mode))
  ;;
  ;; (setq web-mode-content-types-alist
  ;;       '(("json" . "/some/path/.*\\.api\\'")
  ;;         ("xml"  . "/other/path/.*\\.api\\'")
  ;;         ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))

  ;;_. Engine families
  (setq web-mode-enable-engine-detection t)

  ;; Never forget to update the auto-mode-alist.

  ;;_. auto-pairs

  ;; add auto-pair
  ;; (setq web-mode-extra-auto-pairs
  ;;       '(("erb" . (("open" "close")))
  ;;         ("php" . (("open" "close") ("open" "close")))
  ;;         ))

  (add-hook 'web-mode-hook #'rainbow-delimiters-mode-enable)

  ;;_. snippets

  ;; add a snippet
  ;; (add-to-list 'web-mode-extra-snippets '("erb" . (("name" . ("beg" . "end")))))
  ;; (add-to-list 'web-mode-extra-snippets '("php" . (("name" . ("beg" . "end")))))

  ;; expanding
  ;; e.g. auto expand s/ into <span></span>
  (setq web-mode-enable-auto-expanding t)
  ;; HTML
  (add-to-list 'web-mode-expanders '("P/" . "<p>\n | \n</p>"))
  (add-to-list 'web-mode-expanders '("B/" . "<br />\n|"))

  ;;_* disable "<" pair from smartparens.
  (autoload 'sp-local-pair "smartparens" t)
  (sp-local-pair '(web-mode)
                 "<" nil
                 :actions '(:rem insert))

  ;;_* comment
  ;; (add-to-list 'web-mode-comment-formats '("javascript" . "//"))

  ;; close element
  (define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)

  (defun web-mode-element-close-single-tag ()
    "Close single tag like <input />."
    (interactive)
    (if (eq (char-before) ?\ )
        (insert "/>")
      (insert " />")
      ))
  (define-key web-mode-map (kbd "C-c C-/") 'web-mode-element-close-single-tag)
  
  ;; open a new line upper between tag.
  (define-key web-mode-map (kbd "C-o")
    '(lambda ()
       (interactive)
       (previous-line)
       (end-of-line)
       (newline-and-indent)))

  ;; [ web-narrow-mode ] -- narrow for web-mode
  (use-package web-narrow-mode
    :ensure t
    :delight web-narrow-mode
    :init (add-hook 'web-mode-hook 'web-narrow-mode))

  ;; [ company-web ] -- company-mode version of ac-html, complete for web,html,emmet,jade,slim modes.
  (use-package company-web
    :ensure t
    :init
    (defun my-company-web-backends-setup ()
      (interactive)
      (setq-local company-minimum-prefix-length 1)
      (make-local-variable 'company-backends)
      (add-to-list 'company-backends 'company-css)
      (if (featurep 'company-jquery)
          (add-to-list 'company-backends 'company-jquery))
      (add-to-list 'company-backends 'company-tern)
      ;; (add-to-list 'company-backends 'company-web-jade)
      ;; (add-to-list 'company-backends 'company-web-slim)
      (add-to-list 'company-backends 'company-web-html)
      )
    
    (dolist (hook '(web-mode-hook
                    html-mode-hook
                    ))
      (add-hook hook #'my-company-web-backends-setup))

    :config
    ;; company-mode + company-web support

    ;; Enable CSS completion between <style>...</style>
    ;; (defadvice company-css (before web-mode-set-up-ac-sources activate)
    ;;   "Set CSS completion based on current language before running `company-css'."
    ;;   (if (equal major-mode 'web-mode)
    ;;       (let ((web-mode-cur-language (web-mode-language-at-pos)))
    ;;         (if (string= web-mode-cur-language "css")
    ;;             ;; ??
    ;;             ))))

    ;; (advice-add 'company-css :before
    ;;             #'(lambda (&rest _)
    ;;                 (if (equal major-mode 'web-mode)
    ;;                     (let ((web-mode-cur-language (web-mode-language-at-pos)))
    ;;                       (if (string= web-mode-cur-language "css")
    ;;                           (unless css-mode (css-mode))
    ;;                         (if css-mode (css-mode -1)))))))
    
    ;; (defadvice company-tern (before web-mode-set-up-ac-sources activate)
    ;;   "Set `tern-mode' based on current language before running `company-tern'."
    ;;   (if (equal major-mode 'web-mode)
    ;;       (let ((web-mode-cur-language (web-mode-language-at-pos)))
    ;;         (if (or (string= web-mode-cur-language "javascript")
    ;;                 (string= web-mode-cur-language "jsx"))
    ;;             (unless tern-mode (tern-mode 1))
    ;;           (if tern-mode (tern-mode -1))
    ;;           ))))

    (advice-add 'company-tern :before
                #'(lambda (&rest _)
                    (if (equal major-mode 'web-mode)
                        (let ((web-mode-cur-language
                               (web-mode-language-at-pos)))
                          (if (or (string= web-mode-cur-language "javascript")
                                  (string= web-mode-cur-language "jsx"))
                              (unless tern-mode (tern-mode))
                            (if tern-mode (tern-mode -1)))))))

    ;; [C-c ']
    ;; make advantage of `org-src-edit-buffer-p' detection
    ;; let Org-mode Babel src code block auto set `web-mode-engine' for rhtml.
    (defadvice org-edit-special (before org-edit-src-code activate)
      (let ((lang (nth 0 (org-babel-get-src-block-info))))
        (if (string= lang "rhtml")
            (web-mode-set-engine "erb"))))

    (defadvice org-edit-special (after org-edit-src-code activate)
      (if (string= web-mode-engine "erb")
          (add-to-list (make-local-variable 'company-backends) 'company-robe)))
    
    ;; Enable Rails completion between <%= ... %>, or <% ... %>.
    (defadvice company-robe (before web-mode-set-up-ac-sources activate)
      "Set `robe-mode' based on current language before running `company-robe'."
      (if (equal major-mode 'web-mode)
          (let ((web-mode-cur-language (web-mode-language-at-pos)))
            (if (string= web-mode-cur-language "erb")
                (unless robe-mode (robe-mode))
              (if robe-mode (robe-mode -1))
              ))))
    )

  
  ;; [ web-completion-data ] -- dependency for `ac-html', `company-web'
  (use-package web-completion-data
    :ensure t)
  
  ;; [ web-mode-edit-element ] -- helper-functions for attribute- and element-handling.
  (use-package web-mode-edit-element
    :ensure t
    :delight web-mode-edit-element-minor-mode
    :init (add-hook 'web-mode-hook 'web-mode-edit-element-minor-mode))
  )

;; [ ob-html ]
(with-eval-after-load 'web-mode
  (add-to-list 'org-src-lang-modes '("html" . web))
  (add-to-list 'org-src-lang-modes '("rhtml" . web)))

;;; [ RESTful ]

(require 'init-RESTful)


(provide 'init-prog-framework-web)

;;; init-prog-framework-web.el ends here
