;;; init-prog-compile.el --- Summary
;;
;;; Commentary:

;;; Code:

;;; [ compile ]

(setq compilation-ask-about-save nil ; save without asking.
      compilation-scroll-output 'next-error ; stop on first error.
      compilation-skip-threshold 2 ; don't stop on info or warnings.
      )

(setq compilation-window-height nil ; use Emacs default.
      )

(set-face-attribute 'compilation-line-number nil
                    :background (color-darken-name (face-background 'default) 5)
                    :foreground "cyan"
                    :underline nil
                    :weight 'normal
                    :box '(:color "black" :line-width -1))
(set-face-attribute 'compilation-column-number nil
                    :background (color-darken-name (face-background 'default) 5)
                    :foreground "orange"
                    :underline nil
                    :weight 'normal :slant 'normal
                    :box '(:color "black" :line-width -1))
(set-face-attribute 'compilation-info nil
                    :background (color-darken-name (face-background 'default) 5)
                    :underline nil
                    :weight 'normal
                    )
(set-face-attribute 'compilation-warning nil
                    :foreground "orange")
(set-face-attribute 'compilation-error nil
                    :background "dark red"
                    ;; :family nil
                    )
(set-face-attribute 'compilation-mode-line-exit nil
                    :inherit 'compilation-info
                    :foreground "forest green")
(set-face-attribute 'compilation-mode-line-fail nil
                    :foreground "black" :background "dark red")
(set-face-attribute 'compilation-mode-line-run nil
                    :foreground "black")



;;; [ smart-compile ]

;;; Usage:
;; - [M-x smart-compile]


;;; [ smart-compile+ ]

;;; Usage:
;; - [M-x smart-compile]


;;; [ smart-run ]

;; (setq smart-compile-alist '((emacs-lisp-mode emacs-lisp-byte-compile)
;;                             (html-mode browse-url-of-buffer)
;;                             (nxhtml-mode browse-url-of-buffer)
;;                             (html-helper-mode browse-url-of-buffer)
;;                             (octave-mode run-octave)
;;                             ("\\.c\\'" . "gcc -O2 %f -lm -o %n")
;;                             ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
;;                             ("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
;;                             ("\\.java\\'" . "javac %f")
;;                             ("\\.php\\'" . "php -l %f")
;;                             ("\\.f90\\'" . "gfortran %f -o %n")
;;                             ("\\.[Ff]\\'" . "gfortran %f -o %n")
;;                             ("\\.cron\\(tab\\)?\\'" . "crontab %f")
;;                             ("\\.tex\\'" tex-file)
;;                             ("\\.texi\\'" . "makeinfo %f")
;;                             ("\\.mp\\'" . "mptopdf %f")
;;                             ("\\.pl\\'" . "perl -cw %f")
;;                             ("\\.rb\\'" . "ruby -cw %f")))

;; (add-to-list 'smart-compile-alist '("\\.clj" . "clojure %f"))

;; (setq smart-run-alist '(("\\.c$" . "./%n")
;;                         ("\\.[Cc]+[Pp]*$" . "./%n")
;;                         ("\\.java$" . "java %n")
;;                         ("\\.php$" . "php %f")
;;                         ("\\.m$" . "./%f")
;;                         ("\\.scm" . "./%f")
;;                         ("\\.tex$" . "dvisvga %n.dvi")
;;                         (texinfo-mode info
;;                                       (smart-compile-replace "%n.info"))))

;; (add-to-list 'smart-run-alist '("\\.py$" . "python %n"))
;; (add-to-list 'smart-run-alist '("\\.rb$" . "ruby %n"))
;; (add-to-list 'smart-run-alist '("\\.js\\'" . "node %n"))


;;; [ quickrun ] -- Run command quickly.

;; quickrun.el is a extension to execute editing buffer. quickrun.el is similar
;; to executable-interpret, but quickrun.el provides more convenient
;; commands. quickrun.el execute not only script languages(Perl, Ruby, Python
;; etc), but also compiling languages(C, C++, Go, Java etc) and markup language.

;;; Usage:
;;
;; - `quickrun' ::
;; - `quickrun-region' ::
;; - `quickrun-with-arg' ::
;; - `quickrun-shell' ::
;; - `quickrun-compile-only'
;; - `quickrun-replace-region'
;; - `quickrun-autorun-mode'
;; - `helm-quickrun'
;; - `quickrun-after-run-hook'

(use-package quickrun
  :config
  (setq quickrun-focus-p t)

  ;; (quickrun-set-default "c" "c/clang")

  ;; example
  ;; Use this parameter as C++ default
  ;; (quickrun-add-command "c++/c11"
  ;;                       '((:command . "g++")
  ;;                         (:exec    . ("%c -std=c++11 %o -o %e %s"
  ;;                                      "%e %a"))
  ;;                         (:remove  . ("%e")))
  ;;                       :default "c++")
  )



(if (featurep 'quickrun)
    (global-set-key [f5] 'quickrun)
  (global-set-key [f5] 'smart-compile))


(provide 'init-my-prog-compile)

;;; init-my-prog-compile.el ends here
