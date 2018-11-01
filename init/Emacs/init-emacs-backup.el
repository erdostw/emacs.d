;;; init-emacs-backup.el --- init for Emacs backup

;;; Commentary:

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Backup.html

;;; Usage:

;; - `recover-file' :: recover file from backup file suffix with "file~".


;;; Code:

;;; [ backup ]
;; .#foo.txt
;; modify same file by different processes
(setq create-lockfiles t)
;; foo.txt~
;; backup the latest recent file
(setq make-backup-files t)

(setq backup-by-copying t
      backup-by-copying-when-mismatch t
      backup-by-copying-when-privileged-mismatch t
      backup-by-copying-when-linked t
      backup-directory-alist
      '(("." . ".emacs_backups")) ; save backups in $(pwd)/.emacs_backups/filename.bak
      ;; `(("." . ,(expand-file-name "~/.emacs.d/.backups")))
      ;; `((".*" . ,temporary-file-directory)) ; put all under directory /tmp.
      )

;;; [ version control ]
;;; version control with versioned backup filename like "filename.ext.~1~".

(setq version-control nil               ; toggle version control backup?
      vc-make-backup-files nil          ; do not backup files in vc.
      ;; backup-inhibited t                ; do not generate backup
      delete-old-versions t             ; auto delete old versions.
      kept-new-versions 2               ; number of new versions.
      kept-old-versions 2               ; number of old versions.
      )

;;; [ auto-save-mode ] -- toggle auto-saving in the current buffer.

;;; From time to time, Emacs automatically saves each visited file in a separate file,
;;; without altering the file you actually use. This is called “auto-saving”.
;;
;; create filename with "#foo.txt#".
;; periodly save, otherwise lost data when accidently power-off.

;; (setq auto-save-default t
;;       auto-save-list-file-prefix (concat user-emacs-directory "auto-save-list/.saves-")
;;       auto-save-interval (* 60 10)
;;       ;; delete-auto-save-files nil ; don't delete auto-save file when a buffer is saved or killed.
;;       )
;; (auto-save-mode 1)

;;; [ auto-save-visited-mode ]

;; Toggle automatic saving to file-visiting buffers on or off.
;; With a prefix argument ARG, enable regular saving of all buffers visiting a file if ARG
;; is positive, and disable it otherwise. Unlike `auto-save-mode', this mode will
;; auto-save buffer contents to the visited files directly and will also run all
;; save-related hooks. See Info node `Saving' for details of the save process.

(auto-save-visited-mode t)


(provide 'init-emacs-backup)

;;; init-emacs-backup.el ends here
