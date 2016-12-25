;;; init-my-emacs-mode-line.el --- init modeline for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


;; - [C-h v major-mode] for current buffer major mode.
;; - [C-h v minor-mode-alist] for current buffer minor modes list.


;;; [ window-divider-mode ]

(when (boundp 'window-divider-mode)
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1)
  ;; (window-divider-mode 1)
  )


;;; ------------------------------------------------------
;;; separate settings for only active mode-line.

(defvar my/mode-line-selected-window nil)

(defun my/mode-line-record-selected-window ()
  (setq my/mode-line-selected-window (selected-window)))

(defun my/mode-line-update-all ()
  (force-mode-line-update t))

(add-hook 'post-command-hook 'my/mode-line-record-selected-window)

(add-hook 'buffer-list-update-hook 'my/mode-line-update-all)

(defun active ()
  (eq my/mode-line-selected-window (selected-window)))

;;; ------------------------------------------------------

(use-package major-mode-icons
  :ensure t
  :config
  (major-mode-icons-mode 1))

;;; ------------------------------------------------------

;; load necessary package which will be used later.
(use-package company
  :ensure t)
(use-package projectile
  :ensure t
  :defer t
  :init
  (require 'projectile))
(use-package projectile-rails
  :ensure t
  :defer t
  :preface (defvar projectile-rails-mode nil)
  :init
  (require 'projectile-rails)
  )
(require 'vc)
(require 'vc-git)
(use-package flycheck
  :ensure t
  :defer t)

(use-package all-the-icons
  :ensure t
  :defer t)

;; nyan-mode
;; Nyan Mode is an analog indicator of your position in the buffer. The Cat
;; should go from left to right in your mode-line, as you move your point from
;; 0% to 100%.
;; (use-package nyan-mode
;;   :ensure t)
;; (setq nyan-animate-nyancat t
;;       nyan-wavy-trail nil
;;       nyan-animation-frame-interval 0.2
;;       nyan-bar-length 15
;;       nyan-cat-face-number 1
;;       )

;; spinner
(use-package spinner
  :ensure t
  :defer t)
;; (spinner-start 'vertical-breathing 10)
;; (spinner-start 'minibox)
;; (spinner-start 'moon)
;; (spinner-start 'triangle)

(require 'org-timer)

(use-package wc-mode
  :ensure t)

(setq-default
 mode-line-format
 (quote
  (
   ;; active window indicator
   (:eval
    (if (active)
        (propertize "▌"
                    'face '(:foreground "yellow")
                    )))
   
   ;; macro recording -- `kmacro-counter', `kmacro-insert-counter'
   (:eval
    (when (and (active)
               defining-kbd-macro)
      (propertize (format "∆ %s "
                          ;; macro counter
                          kmacro-counter)
                  'face '(:foreground "yellow"))))
   
   ;; emacsclient indicator
   (:eval
    (if (frame-parameter nil 'client)
        (propertize
         " あ "
         'face (if (active)
                   '(:foreground "#333333" :background "yellow" :weight bold)
                 'mode-line-inactive))))

   ;; anzu
   ;; FIXME:
   ;; (:eval
   ;;  (propertize (anzu--update-mode-line)
   ;;              'face '(:foreground "cyan")))
   
   ;; multiple-cursors (mc/)
   ;; (:eval
   ;;  ;; FIXME: (mc/fake-cursor-p ?)
   ;;  (if (and (mc/fake-cursor-p)
   ;;           (> (mc/num-cursors) 1)) ; (if 'mc/fake-cursor-p ...)
   ;;      (propertize (format "[%d]" (mc/num-cursors)) ; `mc/mode-line'
   ;;                  'face '(:foreground "firebrick" :background "black"))))

   ;; input method
   (:eval
    (if current-input-method-title ; `set-input-method'
        (propertize (format " {%s}" current-input-method-title)
                    'face '(:foreground "cyan" :weight bold))))

   ;; mule info: U:[*--]
   (:propertize mode-line-mule-info
                ;; 'face 'font-lock-keyword-face
                )
   
   ;; Buffer status
   ;; mode-line-client
   ;; mode-line-remote
   ;; mode-line-frame-identification
   ;; mode-line-buffer-identification
   (:eval
    (cond
     (buffer-read-only
      (propertize " ⚑ "
                  'face '(:foreground "red" :weight bold)
                  'help-echo "buffer is read-only!!!"))
     ;; (overwrite-mode
     ;;  (propertize "??"))
     ((buffer-modified-p)
      (propertize " ☡ "
                  'face '(:foreground "orange")
                  'help-echo "buffer modified."))

     ;; (mode-line-remote
     ;;  (propertize " R "
     ;;              'face '(:foreground "dark magenta")
     ;;              'help-echo "remote buffer")
     ;;  )
     (t "   ")
     ))

   ;; buffer encoding
   (:eval
    (if (not (memq buffer-file-coding-system
                   '(utf-8
                     utf-8-unix
                     prefer-utf-8-unix
                     utf-8-auto-unix
                     utf-8-emacs-unix
                     undecided-unix ; TODO: remove in future
                     )))
        (list
         (propertize (format "[%s]" (symbol-name buffer-file-coding-system))
                     'face '(:foreground "red")))
      ))

   ;; `ejc-sql' connection name: `ejc-connection-name'
   (:eval
    (when (and (bound-and-true-p ejc-sql-mode)
               (bound-and-true-p ejc-connection-name))
      (propertize (format "%s" ejc-connection-name)
                  'face (if (active)
                            '(:foreground "green")
                          'mode-line-inactive))))
   
   ;; VCS - Git, SVN, CVS,
   (:eval
    (when vc-mode
      (let* ((backend
              (substring vc-mode
                         (+ 2 (length (symbol-name (vc-backend buffer-file-name))))))
             (rev (vc-working-revision buffer-file-name))
             (state (vc-state buffer-file-name))
             (ascii (cond ((memq state '(up-to-date))
                           "✔")
                          ((memq state '(edited))
                           "∓")
                          ((memq state '(added))
                           "✚")
                          ((memq state '(removed))
                           "✖")
                          ((memq state '(conflict))
                           "≠")
                          ((memq state '(needs-merge))
                           "⌥")
                          ((memq state '(needs-updated))
                           "⇧")
                          ((memq state '(unregistered))
                           "-")
                          ((memq state '(missing))
                           "-")
                          (nil
                           "")
                          ))
             (face (cond ((memq state '(up-to-date))
                          'face '(:foreground "green"))
                         ((memq state '(edited added))
                          'face '(:foreground "yellow"))
                         ((memq state '(removed needs-merge needs-update))
                          'face '(:foreground "dark violet"))
                         ((memq state '(unregistered))
                          'face '(:foreground "dim gray"))
                         ((memq state '(conflict))
                          'face '(:foreground "firebrick"))
                         (t
                          'face '(:foreground "deep pink"))
                         )))
        
        (list
         ;; TODO:
         ;; (propertize (all-the-icons-octicon "git-branch")
         ;;             'face `(:inherit ,(if active face 'mode-line-inactive)
         ;;                              :family ,(all-the-icons-octicon-family)
         ;;                              :height 1.25)
         ;;             'display '(raise -0.1))
         
         (propertize (format "%s" backend)
                     'face (if (active) face 'mode-line-inactive)
                     'face '(:foreground "red")
                     )
         (propertize (format "(%s)" ascii)
                     'face (if (active) face 'mode-line-inactive)
                     )
         ))
      ))

   ;; org-tree-slide slide number
   ;; TODO:
   ;; (:eval
   ;;  (when (org-tree-slide--active-p)
   ;;    (propertize (format "[%s]" org-tree-slide--slide-number)
   ;;                'face '(:foreground "cyan"))))

   ;; Flycheck
   (:eval
    (if flycheck-current-errors
        (propertize (flycheck-mode-line-status-text)
                    'face (if (active)
                              '(:foreground "orange" :height 70)
                            'mode-line-inactive))))
   
   ;; buffer name
   (:eval
    (list
     (propertize " ["
                 'face (if (active)
                           '(:foreground "dim gray")
                         'mode-line-inactive))
     (propertize
      "%b"
      'face (if (active)
                '(:foreground "white" :height 75)
              'mode-line-inactive))
     (propertize "]"
                 'face (if (active)
                           '(:foreground "dim gray")
                         'mode-line-inactive))
     ))

   
   ;; wc-mode (word count) `wc-format-modeline-string', `wc-mode-update'.
   ;; (:eval
   ;;  (if (and (featurep 'wc-mode) wc-mode (active))
   ;;      (propertize (wc-format-modeline-string " WC:[%tw]")
   ;;                  'face '(:foreground "green yellow" :height 75))))

   
   ;; mmm-mode


   ;; process: inferior,
   (:eval
    (when (stringp mode-line-process)
      (list
       (propertize " ◌ "
                   'face '(:foreground "cyan" :weight bold :height 120)
                   'help-echo "buffer-process")
       (propertize mode-line-process
                   'face '(:foreground "DeepSkyBlue")
                   'help-echo "buffer-process")
       )))
   
   ;; notifications
   ;; IRC

   ;; company-mode lighter `company-lighter'
   (:eval
    (if (and (boundp company-mode)
             company-mode
             (consp company-backend))
        (list
         ;; (propertize "Ⓐ"
         ;;             'face '(:foreground "DimGray"))
         (propertize " ")
         (propertize (company--group-lighter (nth company-selection
                                                  company-candidates)
                                             company-lighter-base)
                     ;; (symbol-name company-backend)
                     'face '(:foreground "green yellow")
                     'help-echo "company-mode current backend")
         )))

   ;; org-clock
   (:eval
    (when (and (active) org-clock-idle-timer)
      ;; get [0:05] from `org-clock-get-clock-string'
      (propertize (format " ⏳ %s"
                          (org-minutes-to-clocksum-string (org-clock-get-clocked-time)))
                  'face '(:foreground "yellow"))))
   
   ;; org-clock-today (show current org clock)
   (:eval
    (when (and (org-clock-is-active) (active))
      (list
       (propertize (format " ⏰%s" org-clock-today-string)
                   'face '(:foreground "cyan")))
      ))
   
   ;; --------------------------- right align ----------------------------------
   
   ;; Email

   ;; fill with ' '.
   ;; (:propertize "% ")
   
   (:propertize mode-line-end-spaces))
  ))

;; update org-clock timer in mode-line after `org-clock-out-hook'.
;; fix org-clock timer does not disappear after clock out.
(add-hook 'org-clock-out-hook
          '(lambda ()
             ;; (org-clock-update-mode-line)
             (setq org-mode-line-string nil)
             (force-mode-line-update)))

;; --------------------------- right align ----------------------------------

;;; mode-line right align (which replace `mode-line-end-spaces')
;;; you can custom here (add right aligned things here)
(display-time-mode t)
(setq global-mode-string (remove 'display-time-string global-mode-string))
(setq
 mode-line-end-spaces
 (quote
  (
   (:propertize " "
                display (space :align-to (- right 55)))

   ;; nyan-mode
   ;; (:eval
   ;;  (when nyan-mode (list (nyan-create))))

   ;; spinner
   ;; TODO: Let spinner support to be used in custom mode-line as a function.
   ;; '(:eval (spinner-start 'minibox))
   ;;
   ;; '(:propertize  (:eval (spinner-start 'minibox))   ; 'spinner--mode-line-construct
   ;;                :face (:foreground "dark gray"))

   ;; line and column number, relative position
   ;; `mode-line-position'
   ;; '(:propertize " [%p,%I] ")
   (:eval
    (list
     (propertize " ("
                 'face (if (active)
                           '(:foreground "dark gray")
                         'mode-line-inactive))
     (propertize "%02l"
                 'face (if (active)
                           '(:foreground "dark gray" :height 75)
                         'mode-line-inactive))
     (propertize ","
                 'face (if (active)
                           '(:foreground "dark gray")
                         'mode-line-inactive))
     (propertize "%02c"
                 'face (if (active)
                           (if (>= (current-column) 75)
                               '(:foreground "red" :height 75)
                             '(:foreground "dark gray" :height 75))
                         'mode-line-inactive))
     (propertize ")"
                 'face (if (active)
                           '(:foreground "dark gray")
                         'mode-line-inactive))
     (propertize "_%03p "
                 'face (if (active)
                           '(:foreground "dark gray" :height 75)
                         'mode-line-inactive))
     )
    )
   
   ;; projectile
   (:eval
    (if (bound-and-true-p projectile-mode)
        (list
         (propertize " ["
                     ;; 'face 'font-lock-doc-face
                     )
         (propertize "P: "
                     'face (if (active)
                               '(:foreground "cyan" :height 100)
                             'mode-line-inactive))
         (propertize (projectile-project-name) ; `projectile-mode-line'
                     'face (if (active)
                               '(:foreground "green yellow" :height 75)
                             'mode-line-inactive))
         (propertize "] "
                     ;; 'face 'font-lock-doc-face
                     )
         )
      ))
   

   ;; the major mode of the current buffer.
   ;; `mode-name', `mode-line-modes', `minor-mode-alist'
   ;; (:eval
   ;;  (propertize
   ;;   "%m"
   ;;   'face (if (active)
   ;;             '(:foreground "cyan"
   ;;                           :family "Comic Sans MS" :weight bold :height 80)
   ;;           'mode-line-inactive)))
   
   (:eval
    (major-mode-icons-show))
   )))


;; (setq mode-line-in-non-selected-windows t)

;;; 1. color style
;; (set-face-attribute 'mode-line nil
;;                     :inverse-video nil
;;                     :foreground "white" :background "#004A5D"
;;                     :box '(:color "cyan" :line-width 1 :style nil)
;;                     :family "DejaVu Sans Mono"
;;                     :height 90
;;                     )
;; (set-face-attribute 'mode-line-inactive nil
;;                     :inverse-video nil
;;                     :foreground "#444444" :background "black" ; :background "#242424"
;;                     :family "DejaVu Sans Mono"
;;                     :box '(:color "slate blue" :line-width -1 :style nil)
;;                     :height 90
;;                     )

;;; 2. darker style
;; (set-face-attribute 'mode-line nil
;;                     :inverse-video nil
;;                     :foreground "white"
;;                     :background "#484848"
;;                     :box '(:color "dark gray" :line-width 1 :style nil)
;;                     ;; :box '(:color "slate blue" :line-width 1 :style nil)
;;                     :family "DejaVu Sans Mono"
;;                     :height 100
;;                     )
;; (set-face-attribute 'mode-line-inactive nil
;;                     :inverse-video nil
;;                     :foreground "dim gray"
;;                     :background (color-darken-name (face-background 'default) 3)
;;                     :family "DejaVu Sans Mono"
;;                     :box '(:color "dark slate gray" :line-width 1 :style nil)
;;                     :height 100
;;                     )


;;; [ display-time ]

;; (setq display-time-interval 60)
;; (setq display-time-24hr-format nil)
;; (setq display-time-format nil)
;; (setq display-time-day-and-date nil)

;; ;;; event
;; (display-time-event-handler)

;;; Mail
(setq display-time-mail-directory "~/Mails/INBOX/new/")
(setq display-time-use-mail-icon t)
;; (setq display-time-mail-file nil)
;; (setq display-time-mail-function nil)
(display-time-mail-check-directory)

;; ;;; load-average
;; (setq display-time-default-load-average 0)
;; (setq display-time-load-average-threshold 0.5)

(display-time-mode t)


(provide 'init-my-emacs-mode-line)

;;; init-my-emacs-mode-line.el ends here
