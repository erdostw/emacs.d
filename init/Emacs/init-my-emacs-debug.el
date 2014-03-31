;;; init-my-emacs-debug.el --- init for Emacs debug

;;; Commentary:

;;; Tips:
;; - $ emacs --debug-init
;; - $ emacs -Q
;; - $ emacs -q


;;; Code:

(setq debug-on-error t
      debug-on-quit nil
      debug-on-signal nil)

;;; Debug: Trace
(setq stack-trace-on-error t)


;; Sometimes you want to find out where a particular error, warning or just
;; plain annoying message in Messages is coming from.
;; This piece of advice allows you to see the function call sequence that
;; resulted in each message in the Messages buffer:

(defadvice message (before who-said-that activate)
  "Find out who said that thing. and say so."
  (let ((trace nil) (n 1) (frame nil))
    (while (setq frame (backtrace-frame n))
      (setq n     (1+ n)
            trace (cons (cadr frame) trace)) )
    (ad-set-arg 0 (concat "<<%S>>:\n" (ad-get-arg 0)))
    (ad-set-args 1 (cons trace (ad-get-args 1)))
    ))

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



(provide 'init-my-emacs-debug)

;;; init-my-emacs-debug.el ends here
