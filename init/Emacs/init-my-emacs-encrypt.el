;;; init-my-emacs-encrypt.el --- init Emacs encrypt & decrypt

;;; Commentary:


;;; Code:

;;; [ GnuPG ]


;;; [ EasyPG ] --- setup for transparent, automatic encryption and decryption.
(require 'epa)

(require 'epa-file)
(epa-file-enable)

(setq epa-file-encrypt-to "numbchild@gmail.com"
      ;; epa-gpg-program "/usr/bin/gpg"
      epa-file-select-keys t ; use public key
      epa-file-cache-passphrase-for-symmetric-encryption nil
      epa-file-inhibit-auto-save t)

;;; FAQ
;; How to use a non-graphical password prompt for gpg?
;;
;; In X, Emacs 23 seems to pop up a graphical window to ask you the
;; keyphrase. How to let it ask the password in minibuffer?
;;
;; I found the cause for it. The graphical window appears if you run gpg with
;; the --use-agent option. EasyPG adds it (see epg.el) if it sees an environment
;; variable like this one:
;; GPG_AGENT_INFO=/tmp/seahorse-nDQm50/S.gpg-agent:6321:1 (check that with the
;; env command). And you have this variable if for instance you have the program
;; seahorse installed and running (which is the case in Ubuntu). If you
;; uninstall Seahorse, the prompt will always be text instead of graphical. You
;; may have to relogin to X to force Seahorse to close.




(provide 'init-my-emacs-encrypt)

;;; init-my-emacs-encrypt.el ends here
