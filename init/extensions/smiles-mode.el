;;; smiles-mode.el --- Major mode for SMILES.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; smiles major mode
(require 'easymenu)

(defun smiles-cml ()
  "Convert the smiles string in the buffer to CML."
  (interactive)
  (let ((smiles (buffer-string)))
    (switch-to-buffer (get-buffer-create "SMILES-CML"))
    (erase-buffer)
    (insert
     (shell-command-to-string
      (format "obabel -:\"%s\" -ocml 2> /dev/null"
              smiles)))
    (goto-char (point-min))
    (xml-mode)))

(defun smiles-names ()
  (interactive)
  (browse-url
   (format "http://cactus.nci.nih.gov/chemical/structure/%s/names"
           (buffer-string))))

(defvar smiles-mode-map
  nil
  "Keymap for smiles-mode.")

;; adapted from http://ergoemacs.org/emacs/elisp_menu_for_major_mode.html
(define-derived-mode smiles-mode fundamental-mode "smiles-mode"
  "Major mode for SMILES code."
  (setq buffer-invisibility-spec '(t)
        mode-name " ☺")

  (when (not smiles-mode-map)
    (setq smiles-mode-map (make-sparse-keymap)))
  (define-key smiles-mode-map (kbd "C-c C-c") 'smiles-cml)
  (define-key smiles-mode-map (kbd "C-c C-n") 'smiles-names)

  (define-key smiles-mode-map [menu-bar] (make-sparse-keymap))

  (let ((menuMap (make-sparse-keymap "SMILES")))
    (define-key smiles-mode-map [menu-bar smiles] (cons "SMILES" menuMap))

    (define-key menuMap [cml]
      '("CML" . smiles-cml))
    (define-key menuMap [names]
      '("Names" . smiles-names))))


(provide 'smiles-mode)

;;; smiles-mode.el ends here
