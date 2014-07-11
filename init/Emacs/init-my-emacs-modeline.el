;;; init-my-emacs-modeline.el --- init modeline for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; collapse modeline
;; variable: `mode-line-format'
;; use `setq-default` to set it for /all/ modes
;;
;; [C-u C-\ greek RET] then [C-\] to write Greek characters.
;; - [C-h v major-mode] for current buffer major mode.
;; - [C-h v minor-mode-alist] for current buffer minor modes list.

;; load necessary package which will be used later.
(require 'window-number)
(require 'vc)
(require 'vc-git)

;; (default-value mode-line-format)
;; setq-default

(setq-default mode-line-format
              (quote
               (
                (:propertize "%e"
                             face (:foreground "red" :inverse-video nil))

                ;; (:propertize " 暗月:> "
                ;;              face (:foreground "#444444" :background "black")
                ;;              help-echo "九州 ❯ 羽传说 ❯ 向异翅")

                ;; window-number
                (:propertize (:eval (window-number-string))
                             face (:foreground "orange"))

                ;; workgroups2
                (:propertize (wg-mode-line-display-on
                              (:eval
                               (wg-mode-line-string)))
                             face (:foreground "cyan"
                                               ;; :underline "green yellow"
                                               :family "Segoe Print"
                                               ))

                (:propertize "  ")

                ;; mule info
                (:propertize mode-line-mule-info) ; U:
                
                ;; Buffer status
                ;; insert vs overwrite mode, input-method in a tool-tip ("Ovr", "Ins")
                (:propertize "[")
                (:propertize (:eval (if overwrite-mode "♜, " ""))
                             face (:foreground "dark green")
                             help-echo (concat "Buffer is in "
                                                 (if overwrite-mode "overwrite" "insert")))
                ;; was this buffer modified since the last save? ("☡" "Mod")
                (:propertize (:eval (if (buffer-modified-p) "☡"))
                             face (:foreground "deep pink")
                             help-echo "Buffer has been modified")
                ;; is this buffer read-only? ("RO")
                (:propertize (:eval (when buffer-read-only ", ⚑"))
                             face (:foreground "red")
                             help-echo "Buffer is read-only!!!")
                (:propertize "]")

                ;; VCS - Git, SVN, CVS,

                ;; FIXME:
                ;; (:propertize (:eval (git--state-mark-modeline)))

                ;; (:propertize (:eval
                ;;               (git--state-mark-modeline
                ;;                #("    " 0 4
                ;;                  (display
                ;;                   (image :type xpm
                ;;                          :data "/* XPM */\nstatic char * data[] = {\n\"18 13 3 1\",\n\" 	c None\",\n\"+	c #000000\",\n\".	c GreenYellow\",\n\"                  \",\n\"       +++++      \",\n\"      +.....+     \",\n\"     +.......+    \",\n\"    +.........+   \",\n\"    +.........+   \",\n\"    +.........+   \",\n\"    +.........+   \",\n\"    +.........+   \",\n\"     +.......+    \",\n\"      +.....+     \",\n\"       +++++      \",\n\"                  \"};"
                ;;                          :ascent center)
                ;;                   help-echo "File status in git: uptodate")))))
                

                ;; vc indicator
                (:propertize (vc-mode vc-mode)
                             face (:foreground "#C05800")
                             help-echo (vc-mode))

                ;; (vc-mode (:eval (propertize vc-mode
                ;;                             'face (pcase (vc-state buffer-file-truename)
                ;;                                     (`up-to-date '(:foreground "green"))
                ;;                                     (`edited nil)
                ;;                                     (_ '(:foreground "red"))))))

                ;; (vc-mode (:eval (propertize vc-mode 'face
                ;;   (pcase (vc-state buffer-file-truename)
                ;;     (`up-to-date 'mode-line-important)
                ;;     (`edited                      nil)
                ;;     (_             'mode-line-warning)))))

                ;; the buffer name; the filename as a tool tip
                ;; mode-line-client
                ;; mode-line-remote
                ;; mode-line-frame-identification
                ;; mode-line-buffer-identification
                (:propertize " [")
                (:propertize "%b"
                             face (:foreground "dark gray")
                             help-echo (buffer-file-name))
                (:propertize "] ")

                ;; git-emacs (magit)

                ;; line and column number, relative position
                ;; mode-line-position
                ;; '%02' to set to 2 chars at least; prevents flicking
                (:propertize "(%02l,%02c),%03p"
                             face (:foreground "#444444")
                             ;; (:eval (if (>= (current-column) 80)
                             ;;            face (:foreground "red" :weight 'bold)))
                             )

                ;; relative position, size of file
                ;; (:propertize " [%p,%I] ")

                ;; process
                ;; mode-line-process

                ;; notifications
                ;; ERC
                ;; TODO [#e,i]

                ;; the major mode of the current buffer.
                (:propertize " ("
                             face (:foreground "orange red"))
                (:propertize "/:%m:/"
                             face (:foreground "green yellow"
                                               :family "Segoe Print"
                                               )
                ;; (:propertize "|")
                ;; ;; list of minor modes
                ;; (:propertize minor-mode-alist
                ;;              face (:foreground "dim gray"))
                (:propertize ") "
                             face (:foreground "orange red"))

                ;; --------------------------- right align ----------------------------------
                
                ;; Email

                ;; newsticker RSS new feeds.
                ;; (:propertize (:eval (let ((unread (or (newsticker--stat-num-items-total 'new) 0)))
                ;;                       (when (> unread 0)
                ;;                         (format "RSS: %d" unread)
                ;;                         )))
                ;;              face (:foreground "green")
                ;;              help-echo (format "You have %d unread RSS items! [C-c r]" unread)
                ;;              mouse-face 'mode-line-highlight)

                ;; ;; add the time, with the date and the emacs uptime in the tool-tip
                ;; (:propertize (:eval (format-time-string "%H:%M"))
                ;;              face (:foreground "white")
                ;;              help-echo (concat (format-time-string "%c; ")
                ;;                                (emacs-uptime "Uptime: %D, %z%2h:%.2m")))
                
                ;; fill with ' '.
                ;; (:propertize "% ")

                ;; Org-mode clock
                (:propertize
                 ;; TODO: concatenate the long string.
                 ;; global-mode-string
                 ;; (t org-mode-line-string org-timer-mode-line-string)
                 (t org-timer-mode-line-string) ; org-timer default time 25, (Pomodoro time management technique)
                 face (:foreground "cyan"))
                
                (:propertize mode-line-end-spaces)
                )))

;;; mode-line right align (which replace `mode-line-end-spaces' to implement the right alignment.)
;;
;; (display-time)
;; (setq global-mode-string (remove 'display-time-string global-mode-string))
;; (setq mode-line-end-spaces
;;       (list (propertize " " 'display '(space :align-to (- right 10)))
;;             ;; you can custom here (add right aligned things here)
;;             ;; '(:propertize " /铁甲依然在 !/ "
;;             ;;               face (:foreground "cyan")
;;             ;;               help-echo "我不要这样生，也不要那样死！\n\n 人的一生是如此的的短暂，而你还有很多的事情,很多的梦想 需要曲实现。\n我不想那样生存，也不想就 这样死去，所以，我要拼命去实现我的想法。")
;;             'display-time-string
;;             ))


(defvar mode-line-cleaner-alist
  '((auto-complete-mode . " ac") ; AC (auto-complete)
    (yas-minor-mode . "") ; yas (yasnippet)
    (helm-mode . "") ; Helm (helm),
    (paredit-mode . "") ; Paredit (paredit)
    (paredit-everywhere-mode . "") ; Par-
    (eldoc-mode . "") ; ElDoc (ElDoc)
    ;; minor modes
    (autopair-mode . "") ; pair (auto-pair)
    (auto-indent-mode . "")
    (auto-indent-minor-mode . "") ; AI (auto-indent)
    (highlight-indentation-mode . "") ; ||, ▸
    (highlight-indentation-current-column-mode . "") ; |
    (visual-line-mode . "") ; vl (visual-line)
    (global-visual-line-mode . "") ; vl (visual-line)
    (hs-minor-mode . "") ; hs (hideshow)
    (abbrev-mode . "") ; (abbrev)
    (defining-kbd-macro . " Def:macro") ; Def
    (undo-tree-mode . "") ; Undo-tree (undo-tree)
    (outline-minor-mode . "") ; Outl (outline)
    (global-whitespace-mode . "") ; WS (global-whitespace-mode)
    (whitespace-mode . "") ; ws (whitespace-mode)
    (global-whitespace-newline-mode . "") ; NL (global-whitespace-newline-mode)
    (whitespace-newline-mode . "") ; nl (whitespace-newline-mode)
    (whitespace-cleanup-mode . "") ; WSC
    (auto-fill-mode . "") ; Fill (auto-fill-mode), A/Fill
    (auto-fill-function . "") ; Fill (auto-fill-function), A/Fill
    (anzu-mode . "") ; Anzu
    (rainbow-mode . "") ; Rbow (rainbow-mode)
    (rainbow-delimiters-mode . "") ; (rainbow-delimiters-mode)
    (auto-capitalize . "") ; Cap, (auto-capitalize), A/Cap
    (ispell-minor-mode . "") ; Spell (ispell-minor-mode)
    (flyspell-mode . "") ; Fly (flyspell)
    (flycheck-mode . flycheck-mode-line) ; FlyC
    (flymake-mode . 'flymake-mode-line) ; FlyM
    (hi-lock-mode . "") ; syntax highlight
    (compilation-minor-mode . " Compilation") ; Compilation
    (compilation-shell-minor-mode . " Shell-Compile") ; Shell-Compile
    (compilation-in-progress . " Compiling") ; Compiling
    (next-error-follow-minor-mode . "") ; Fol
    (visible-mode . "") ; Vis (visible-mode)
    (window-number-mode . "") ; window-number
    (workgroups-mode . "") ; wg
    (fic-mode . "") ; FIC (fic-mode)
    ;; Project
    (projectile-mode . projectile-mode-line)        ; " Projectile" (projectile)
    ;; major modes
    ;; Tools
    ;; Org
    (org-mode . "Org") ; Org (org-mode)
    (org-indent-mode . "") ; Ind (org-indent-mode)
    (org-capture-mode . "Org/Capture") ; Rem;
    (org-cdlatex-mode . "Org/OCDL") ; OCDL;
    (orgstruct-mode . "Org/Struct") ; OrgStruct;
    (org-agenda-mode . "*Org Agenda*")
    ;; VCS
    (magit-auto-revert-mode . "") ; MRev
    ;; Programming Languages modes
    (lisp-interaction-mode . "λ:>")
    (lisp-mode . "λ") ; Lisp mode
    (emacs-lisp-mode . "Emacs Lisp") ; Emacs-Lisp (emacs-lisp)
    (elisp-slime-nav-mode . "") ; SliNav
    (sh-mode . "#!") ; shell-script (Bash)
    (ruby-mode . "Ruby")
    (enh-ruby-mode . "EnRuby") ; EnhRuby (Enhanced-Ruby-Mode)
    (ruby-electric-mode . " Ruby/Elec")
    (ruby-block-mode . " Ruby/Block")
    (ruby-test-mode . " Ruby/Test")
    (rspec-mode . " RSpec")
    (robe-mode . "") ; robe
    (rinari-minor-mode . " Rinari") ; Rin
    (ruby-capistrano-minor-mode . " Capstrano") ; capstrano
    (ruby-compilation-minor-mode . " Ruby:comp") ; ruby:comp
    (inf-ruby-minor-mode . "")
    (python-mode . "Python")
    (c-mode . "C")
    (c++-mode . "C++")
    (go-mode . "Go")
    (lua-mode . "Lua")
    (rust-mode . "Rust")
    (clojure-mode . "Clojure")
    (ocaml-mode . "OCaml")
    (scala-mode . "Scala")
    (ess-transcript-minor-mode . "") ; ESStr
    (ess-listing-minor-mode . "") ; ESSlst
    (noweb-mode . "Noweb") ; Noweb
    (noweb-font-lock-mode . "") ; NWFL
    (html-mode . "HTML")
    (zencoding-mode . "Zen") ; " Zen" (zencoding-mode)
    (css-mode . "CSS")
    (js-mode . "JavaScript")
    (js2-mode . "JavaScript(2)")
    (js2-minor-mode . "JavaScript2")
    (js3-mode . "JavaScript(3)")
    (inferior-js-keys-mode . "") ; InfJS
    ;; TODO (haml-mode . "Haml")
    ))

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)


;; (setq mode-line-in-non-selected-windows t)

;; modeline colors
(set-face-attribute 'mode-line nil
                    :inverse-video nil
                    :foreground "#444444"
                    :background "black"
                    ;; :box '(:color "#444444" :line-width 1 :style nil) :height 90
                    :family "DejaVu Sans Mono"
                    )
(set-face-attribute 'mode-line-inactive nil
                    :inverse-video nil
                    :foreground "#444444" :background "#242424"
                    :family "DejaVu Sans Mono"
                    ;; :box '(:color "#444444" :line-width 1 :style nil)
                    ;; :height 90
                    )


;;; [ display-time ]

;; (display-time-mode 1)

;; (setq display-time-interval 60)
;; (setq display-time-24hr-format nil)
;; (setq display-time-format nil)
;; (setq display-time-day-and-date nil)
;; ;;; event
;; (display-time-event-handler)
;; ;;; Mail
;; (setq display-time-use-mail-icon t)
;; (setq display-time-mail-function nil)
;; (setq display-time-mail-file nil)
;; (setq display-time-mail-directory "~/Mails/INBOX/new/")
;; (display-time-mail-check-directory)
;; ;; (display-time-mail-check-directory)
;; ;;; load-average
;; (setq display-time-default-load-average 0)
;; (setq display-time-load-average-threshold 0.5)



;;; [ diminish ]

;;; Usage:
;; Diminishing Major Modes
;; (add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "Emacs Lisp"))) ; emacs lisp




(provide 'init-my-emacs-modeline)

;;; init-my-emacs-modeline.el ends here
