;;; init-linux.el --- init for Linux
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ systemd-mode ] -- Emacs major mode for editing systemd units.

(use-package systemd
  :ensure t
  :config
  (add-hook 'systemd-mode-hook
            (lambda ()
              (my-company-add-backend-locally 'systemd-company-backend)))
  )


;;; [ helm-systemd ] -- helm interface to control systemd units.

(use-package helm-systemd
  :ensure t
  :config
  (setq helm-systemd-list-not-loaded t
        helm-systemd-list-all nil
        )
  )


;;; [ nginx-mode ]

(use-package nginx-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist
               '("nginx\\.conf\\'" . nginx-mode)
               '("/etc/nginx/.*" . nginx-mode))
  )


;;; [ apache-mode ]

(use-package apache-mode
  :ensure t)


;;; [ PulseAudio ]

(add-to-list 'auto-mode-alist '("\\.pa\\'" . conf-mode))


(provide 'init-linux)

;;; init-linux.el ends here
