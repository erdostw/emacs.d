;;; init-tramp.el --- init for tramp
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Tramp ]

(use-package tramp
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'tramp-cache
    (setq tramp-persistency-file-name (concat user-emacs-directory "tramp")))
  
  (setq tramp-auto-save-directory "/tmp")

  ;; (tramp-debug-buffer-name t)
  ;; (setq tramp-verbose 10)

  ;; speed-up tramp.
  (setq tramp-completion-reread-directory-timeout nil)

  ;; <default method>
  (setq tramp-default-method "ssh")

  :config
  ;; (add-to-list 'tramp-default-method-alist
  ;;              '("\\`\\(127\\.0\\.0\\.1\\|::1\\|dark\\|localhost6?\\)\\'"
  ;;                "\\`root\\'"
  ;;                "su"))
  (add-to-list 'tramp-default-method-alist '(nil "%" "smb"))
  
  ;; (add-to-list 'tramp-methods `(,))

  ;; <default user>
  ;; NOTE: this cause `ob-shell' :dir /sudo:: error.
  ;; (add-to-list 'tramp-default-user-alist
  ;;              '(("\\`su\\(do\\)?\\'" nil "root")))
  ;; (add-to-list 'tramp-default-user-alist
  ;;              '("ssh" ".*\\.somewhere\\.else\\'" "john"))

  ;; <default host>
  ;; (add-to-list 'tramp-default-host-alist)

  ;; ad-hoc proxy
  ;; (setq tramp-save-ad-hoc-proxies t)

  ;; <default proxy>
  ;; (add-to-list 'tramp-default-proxies-alist)

  ;; Multi-hops SSH proxy bridges
  ;; (add-to-list 'tramp-default-proxies-alist '(HOST USER SSH-PROXY))

  ;; Tramp completion
  ;; (add-to-list 'tramp-completion-function-alist)

  ;; <predefined connection property>
  ;; (add-to-list 'tramp-connection-properties
  ;;              (list (regexp-quote "/ssh:user@randomhost.your.domain:")
  ;;                    "busybox" t))

  ;; use the settings in ~/.ssh/config instead of Tramp's
  ;; (setq tramp-use-ssh-controlmaster-options nil)

  ;; hotfix
  ;; (setq tramp-ssh-controlmaster-options
  ;;       "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  ;; (setq tramp-ssh-controlmaster-options
  ;;       "-o ControlMaster=auto -o ControlPath='ssh_%C' -o ControlPersist=no")
  
  ;; change SHELL environment variable to solve Tramp hangs issue.
  (eval-after-load 'tramp
    '(setenv "SHELL" "/bin/bash"))

  ;; fix /bin/zsh no such file or directory issue on remote host.
  (setq explicit-shell-file-name "/bin/bash")

  ;; don't generate backups for remote files opened as root (security hazzard)
  (setq backup-enable-predicate
        (lambda (name)
          (and (normal-backup-enable-predicate name)
               (not (let ((method (file-remote-p name 'method)))
                      (when (stringp method)
                        (member method '("su" "sudo"))))))))
  
  ;; [ sh ]
  (use-package tramp-sh
    :defer t
    :init (add-to-list 'tramp-remote-path "~/bin"))
  
  ;; [ sudo in Tramp ]

  ;; [ Android adb ]
  ;; (use-package tramp-adb
  ;;   :defer t)
  )

;;; [ counsel-tramp ] -- Tramp with Ivy/counsel interface.

(use-package counsel-tramp
  :ensure t
  :defer t
  :commands (counsel-tramp)
  :init (defalias 'exit-tramp 'tramp-cleanup-all-buffers))

;;; [ helm-tramp ] -- Tramp with Helm interface.

;; (use-package helm-tramp
;;   :ensure t
;;   :defer t
;;   :config
;;   (defalias 'exit-tramp 'tramp-cleanup-all-buffers)
;;   (with-eval-after-load 'helm-config
;;     (define-key helm-command-map (kbd "M-t") 'helm-tramp))
;;   )



(provide 'init-tramp)

;;; init-tramp.el ends here
