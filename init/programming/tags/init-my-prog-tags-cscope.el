;;; init-my-prog-tags-cscope.el --- init for cscope etc
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


(unless (boundp 'cscope-prefix)
  (define-prefix-command 'cscope-prefix)
  (define-key my-prog-lookup-tags-map (kbd "c") 'cscope-prefix))



(defun cscope-build (dir)
  "My custom function to execute shell command: $ cscope -bR."
  (interactive "Dcscope build database directory: ")
  (let* ((dir (expand-file-name dir))
         (buffer-name (format "*cscope-build-%s" dir))
         (cscope-buffer (get-buffer-create buffer-name))
         process)
    (with-current-buffer cscope-buffer
      (if (get-buffer-process buffer-name)
          (kill-process (get-buffer-process buffer-name)))
      (setq default-directory dir)
      (setq process (start-file-process buffer-name buffer-name
                                        "cscope" "-bR"))
      (set-process-query-on-exit-flag process nil)
      (accept-process-output process 3)
      (if (looking-at "TODO: REGEXP about cscope build error")
          (progn
            (when cscope-buffer (kill-buffer cscope-buffer))
            (message "cscope build database failed"))
        (progn
          (message "cscope: database build %s : OK" dir))
        ))
    cscope-buffer))


;;; [ cscope ] -- An interface to Joe Steffen's "cscope" C browser.

;; Usage:
;;
;; - $ cscope -bR :: normal usage command.
;; - $ cscope -b -R -q -k ::
;; - `cscope-minor-mode' :: enable minor mode will enable keybindings.


;;; [ xcscope ] -- interface of cscope.

;; TODO: (setq cscope-)

(cscope-setup)


;;; [ ascope ] -- another interface of cscope.

;;; ascope is an improvement over xcscope that runs all queries through a single
;;; cscope process, instead of starting a new process and reloading the database
;;; for each query.

;; Usage:
;;
;; - `ascope-init' :: load the cscope database.
;;   This command must be issue prior to issue any other command below,
;;   the directory feed to this command must be the directory include
;;   the `cscope.out' file.
;; - `ascope-find-global-definition'
;; - `ascope-find-this-symbol'
;; - `ascope-find-this-text-string'
;; - `ascope-find-functions-calling-this-function'
;; - `ascope-find-called-functions'
;; - `ascope-find-files-including-file'
;; - `ascope-all-symbol-assignments'
;; - `ascope-clear-overlay-arrow'
;; - `ascope-pop-mark'
;;
;; run next commands in the search result buffer (*Result)
;;
;; - [n] :: `ascope-next-symbol'
;; - [p] :: `ascope-prev-symbol'
;; - [Enter] :: `ascope-select-entry-other-window-delete-window'

;; (require 'ascope)

;; TODO:
;; (define-key ascope-list-entry-mode-map (kbd "q")
;;   '(lambda ()
;;      (kill-buffer "*Result*")))


;;; [ bscope ]


;;; [ rscope ] -- It is born to challenge its cousins : xscope, ascope, bscope

;;; rscope is a new implementation taking its roots from ascope, thus running a
;;; single cscope process for each cscope database. It’s a bit more versatile
;;; than ascope because it copes with multiple cscope databases (and hence
;;; spawns one cscope process per database once).

;; - where is this variable used?
;; - what is the value of this preprocessor symbol?
;; - where is this function in the source files?
;; - what functions call this function?
;; - what functions are called by this function?
;; - where does the message "out of space" come from?
;; - where is this source file in the directory structure?
;; - what files include this header file?

;;; Usage:
;;
;; - [C-c s] :: prefix.

;; (require 'rscope)

(use-package rscope
  :config
  (setq rscope-keymap-prefix (kbd "C-c l t c"))

  (setq rscope-allow-arrow-overlays t
        rscope-overlay-arrow-string "=>"
        rscope-hierarchies-shorten-filename t)

  ;; (set-face-attribute 'rscope-function-face nil
  ;;                     :foreground "green")
  ;; (set-face-attribute 'rscope-line-face nil
  ;;                     :foreground "orange")
  ;; (set-face-attribute 'rscope-line-number-face nil
  ;;                     :foreground "red")
  )


;;; [ helm-cscope ] -- cscope with Helm interface.

;;; Usage:
;;
;; - `helm-cscope-' :: prefix

(dolist (hook '(c-mode-hook
                c++-mode-hook
                objc-mode-hook
                ;; prog-mode-hook
                ))
  (add-hook hook 'helm-cscope-mode))

(use-package helm-cscope
  :config
  (define-key cscope-prefix (kbd "s") 'helm-cscope-find-this-symbol)
  (define-key cscope-prefix (kbd "d") 'helm-cscope-find-global-definition)
  (define-key cscope-prefix (kbd "f") 'helm-cscope-find-called-function)
  (define-key cscope-prefix (kbd "c") 'helm-cscope-find-calling-this-funtcion)
  )



;;; a possibly handy hack:
;; (defun my-find-tag(&optional prefix)
;;   "union of `find-tag' alternatives. decides upon major-mode"
;;   (interactive "P")
;;   (if (and (boundp 'cscope-minor-mode)
;;          cscope-minor-mode)
;;       (progn
;;         (ring-insert find-tag-marker-ring (point-marker))
;;         (call-interactively
;;          (if prefix
;;              'cscope-find-this-symbol
;;            'cscope-find-global-definition-no-prompting
;;            )))
;;     (call-interactively 'find-tag)))
;;
;; (substitute-key-definition 'find-tag 'my-find-tag global-map)



(define-key cscope-prefix (kbd "b") 'cscope-build)

(cond
 ;; [ rscope ]
 ((featurep 'rscope)
  (define-key cscope-prefix (kbd "s") 'rscope-find-this-symbol)
  (define-key cscope-prefix (kbd "=") 'rscope-all-symbol-assignments)
  (define-key cscope-prefix (kbd "d") 'rscope-find-global-definition)
  (define-key cscope-prefix (kbd "c") 'rscope-find-functions-calling-this-function)
  (define-key cscope-prefix (kbd "C") 'rscope-find-called-functions)
  (define-key cscope-prefix (kbd "t") 'rscope-find-this-text-string)
  (define-key cscope-prefix (kbd "i") 'rscope-find-files-including-file)
  (define-key cscope-prefix (kbd "h") 'rscope-find-calling-hierarchy)
  )
 
 ;; [ helm-cscope ]
 ((and (featurep 'helm) (featurep 'helm-cscope))
  (define-key cscope-prefix (kbd "s") 'helm-cscope-find-this-symbol)
  (define-key cscope-prefix (kbd "a") 'helm-cscope-find-assignments-to-this-symbol)
  (define-key cscope-prefix (kbd "q") 'helm-cscope-find-called-function)
  (define-key cscope-prefix (kbd "d") 'helm-cscope-find-calling-this-funtcion)
  (define-key cscope-prefix (kbd "p") 'helm-cscope-find-egrep-pattern)
  (define-key cscope-prefix (kbd "g") 'helm-cscope-find-global-definition)
  (define-key cscope-prefix (kbd "i") 'helm-cscope-find-files-including-file)
  (define-key cscope-prefix (kbd "f") 'helm-cscope-find-this-file)
  (define-key cscope-prefix (kbd "t") 'helm-cscope-find-this-text-string)
  )

 ;; [ cscope ]
 (t
  ;; FIXME: (define-key cscope-prefix (kbd "s") 'cscope-select-entry-one-window)
  (define-key cscope-prefix (kbd "c") 'cscope-find-this-symbol)
  )
 )

(define-key cscope-prefix (kbd "n") 'cscope-history-backward-line-current-result)
(define-key cscope-prefix (kbd "N") 'cscope-history-forward-file-current-result)



(provide 'init-my-prog-tags-cscope)

;;; init-my-prog-tags-cscope.el ends here
