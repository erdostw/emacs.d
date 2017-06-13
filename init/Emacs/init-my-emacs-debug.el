;;; init-my-emacs-debug.el --- init for Emacs debug

;;; Commentary:


;;; Code:

(unless (boundp 'emacs-debug-prefix)
  (define-prefix-command 'emacs-debug-prefix))
(global-set-key (kbd "C-x C-d") 'emacs-debug-prefix)


(defun emacs-version-detail ()
  "Insert version of Emacs and 7 characters of the commit hash."
  (interactive)
  (insert
   (format "GNU Emacs %s (commit %s)"
           emacs-version
           (substring (emacs-repository-get-version) 0 7))))


;;; [ debug ] -- Emacs built-in debugger.

(use-package debug
  :config
  ;; (setq debug-on-error t
  ;;       debug-on-quit nil)
  )

;;; [ Edebug ] -- Edebug is a source level debugger.

(use-package edebug
  :bind (:map emacs-lisp-mode-map
              ("C-x C-d C-e" . edebug-mode)
              ("C-x C-d f" . edebug-defun)
              ("C-x C-d b" . edebug-set-breakpoint)
              ("C-x C-d e" . edebug-on-entry)
              ("C-x C-d C-l" . edebug-where))
  :config
  (setq edebug-trace t)
  )

;;; [ edebug-x ] -- Extensions for Edebug.

(use-package edebug-x
  :ensure t
  :config
  (set-face-attribute 'hi-edebug-x-stop nil
                      :background "dark red")
  (set-face-attribute 'hi-edebug-x-debug-line nil
                      :background "dim gray")
  )


;;; [ bug-hunter ] -- Hunt down errors in elisp files.

(use-package bug-hunter
  :ensure t
  :commands (bug-hunter-file bug-hunter-init-file)
  )


;; Sometimes you want to find out where a particular error, warning or just
;; plain annoying message in Messages is coming from.
;; This piece of advice allows you to see the function call sequence that
;; resulted in each message in the Messages buffer:

;; (defadvice message (before who-said-that activate)
;;   "Find out who said that thing. and say so."
;;   (let ((trace nil) (n 1) (frame nil))
;;     (while (setq frame (backtrace-frame n))
;;       (setq n     (1+ n)
;;             trace (cons (cadr frame) trace)) )
;;     (ad-set-arg 0 (concat "<<%S>>:\n" (ad-get-arg 0)))
;;     (ad-set-args 1 (cons trace (ad-get-args 1)))
;;     ))

;; ;;; To deactivate this, call
;; (ad-disable-advice 'message 'before 'who-said-that)
;; (ad-update 'message)

;; ;;; Similarly, to get timestamps:
;; (defadvice message (before when-was-that activate)
;;   "Add timestamps to `message' output."
;;   (ad-set-arg 0 (concat (format-time-string "[%Y-%m-%d %T %Z] ")
;;                         (ad-get-arg 0)) ))

;;; And to deactivate this, call
;; (ad-disable-advice 'message 'before 'when-was-that)
;; (ad-update 'message)



;;; [ Checkpoints ]

;; Since, this is one huge file, it is often hard to debug where a particular
;; error has occurred, and therefore, I need some visual clue of some type,
;; a.k.a. checkpoints. The following functions, together, help me with that. I
;; can, simply, make a call to the my/checkpoint function, in order to
;; echo something inside my *Messages* buffer, and immediately, know nearby
;; location of where Emacs has stopped loading this configuration. Not to
;; mention, these checkpoints, further, help me by acting as indirect comments.

;; subtract two time entities
(defun my/time-subtract-millis (b a)
  "Function that can subtract time string A from time string B."
  (* 1000.0 (float-time (time-subtract b a))))

;; convenient function to measure load-time since initialization
(defun my/load-time()
  "Return total load-time from the initialization."
  (my/time-subtract-millis (current-time) before-init-time))

;; function to display which section is being loaded..
(defun my/checkpoint (msg)
  "Echo MSG to *Messages*, thereby, making it act as a checkpoint."
  (if debug-on-error (message "- At =%.2fms=, I %s.." (my/load-time) msg)))

;; an example of above
(my/checkpoint "initialized benchmarking")


;;; test Emacs init files with batch

;;; Usage:
;;
;; This function will quietly run a batch Emacs with your current config to see
;; if it errors out or not.
;;
;; in case that there were no start up errors, it will echo "All is well".  when
;; there's an error, it will pop to a *startup error* buffer with the error
;; description.
;;
;; The nice thing about this is that in case of an error you have a functional
;; Emacs to fix that error, since fixing errors with emacs -Q is quite painful.
;;
;; Another approach could be to just start a new Emacs instance, and close the
;; window in case there isn't an error. So all that the code above does is
;; automate closing the window (sort of, since the window never opens). Still, I
;; think it's pretty cool. And you could attach it to the after-save-hook of
;; your .emacs, or a timer.
;;
;; You could even configure Emacs to send you an email in case it notices that
;; there will be an error on the next start up. Or add the test to
;; before-save-hook and abort the save in case it results in an error. That's
;; some HAL 9000 level stuff right there:

(defun my-test-emacs-init ()
  (interactive)
  (require 'async)
  (async-start
   (lambda () (shell-command-to-string
               "emacs --batch --eval \"
(condition-case e
    (progn
      (load \\\"~/.emacs\\\")
      (message \\\"-OK-\\\"))
  (error
   (message \\\"ERROR!\\\")
   (signal (car e) (cdr e))))\""))
   `(lambda (output)
      (if (string-match "-OK-" output)
          (when ,(called-interactively-p 'any)
            (message "All is well"))
        (switch-to-buffer-other-window "*startup error*")
        (delete-region (point-min) (point-max))
        (insert output)
        (search-backward "ERROR!")))))



;;; [ Benchmarking ]


;;; [ profiler ]

(unless (boundp 'emacs-profiler-prefix)
  (define-prefix-command 'emacs-profiler-prefix))
(define-key emacs-debug-prefix (kbd "p") 'emacs-profiler-prefix)

(use-package profiler
  :bind (:map emacs-profiler-prefix
              ("p" . profiler-start)
              ("s" . profiler-stop)
              ("r" . profiler-report))
  )


(provide 'init-my-emacs-debug)

;;; init-my-emacs-debug.el ends here
