;;; init-org-contacts.el --- init for Org Contacts
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-contacts ] -- Contacts management in Org-mode.

(use-package org-contacts
  :demand t
  :commands (org-contacts org-contacts-anniversaries)
  :init (setq org-contacts-files (list (concat org-directory "/Contacts/Contacts.org")))
  ;; Create agenda view for contacts matching NAME.
  (unless (boundp 'Org-prefix)
    (define-prefix-command 'Org-prefix))
  (define-key Org-prefix (kbd "M-c") 'org-contacts)

  (setq org-capture-templates
        (append '(("C" "[C]ontact"
                   entry (file (lambda () (car org-contacts-files)))
                   "** %^{NAME}
:PROPERTIES:
:DATE: %^U
:AVATAR: %^{Avatar}
:NICK: %^{Nick}
:NAME(Chinese): %^{Name(Chinese)}
:NAME(English): %^{Name(English)}
:GENDER: %^{Gender|Transgender|Male|Female}
:RELATIONSHIP: %^{Relationship|Internet|Meet|Friend|Good Friend|Boy Friend|Girl Friend|Workmate|Classmate|Schoolmate}
:FIRST-MEET: %^U  %^{How is the first-time meet? when? where? how?}
:MOBILE: %^{Mobile Phone}
:EMAIL: %^{Email}
:GitHub: %^{GitHub}
:ADDRESS(home): %^{address(home)}
:ADDRESS(live): %^{address(live)}
:LANGUAGES: %^{Languages|Chinese|Chinese, English|English|Japanese|Korean}
:EDUCATION: %^{Education}
:School(university):
:SKILLS: %^{Skills|Programming|Economy}
:Programming-Skills: %^{Programming Skills|Emacs|Web|Computer System|Cloud Computation}
:Programming-Languages: %^{Programming Languages|LISP|Common Lisp|Clojure|Emacs Lisp|Java|C/C++|Python|Ruby|PHP}
:Occupation: %^{Occupation|Programmer|Freelancer|Businessman|Servant|Arter}
:Hobbies: %^{Hobbies|Reading|Music|Movie|Travel}
:END:"
                   :empty-lines 0
                   :jump-to-captured t
                   )
                  )
                org-capture-templates))

  (setq org-contacts-matcher
        "NAME<>\"\"|EMAIL<>\"\"|Mailing-List<>\"\"|ALIAS<>\"\"|RELATIONSHIP<>\"\"|PHONE<>\"\"|ADDRESS<>\"\"|BIRTHDAY<>\"\"|PROGRAMMING-SKILLS<>\"\"|SKILLS<>\"\"|EDUCATION<>\"\"|JOBS<>\"\"|NOTE"
        )
  
  ;; avatar
  (setq org-contacts-icon-use-gravatar nil
        org-contacts-icon-property "AVATAR")
  (setq org-contacts-birthday-property "BIRTHDAY"
        org-contacts-birthday-format "Birthday: %h (%Y)")
  
  (dolist (hook '(message-mode-hook
                  mu4e-compose-mode-hook))
    (add-hook hook 'org-contacts-setup-completion-at-point))
  
  :config
  ;; [C-c C-x p] add "EMAIL" property complete with `mu4e~contacts' source.
  (when (and (featurep 'mu4e) (not (null mu4e~contacts)))
    (defun org-property-email-complete (prompt &rest args)
      (if (bound-and-true-p mu4e~contacts) ; `mu4e~contacts' is initialized after started `mu4e'.
          (if-let ((contact (completing-read prompt mu4e~contacts))
                   (has-name? (string-match-p "<.*>" contact))) ; detect special org-contacts candidate which only has email without name.
              ;; extract email from org-contacts candidate if have name.
              (let* ((match-start (1+ (string-match "<.*>" contact)))
                     (length (1- (length contact)))
                     (email (substring contact match-start length))
                     (name (substring-no-properties contact 0 (- match-start 2))))
                (kill-new name)
                email)
            contact) ; the contact value is the email when no name.
        (user-error "`mu4e~contacts' is available after mu4e initialized.")))
    (add-to-list 'org-property-set-functions-alist '("EMAIL" . org-property-email-complete))))

(use-package helm-org-rifle
  :ensure t
  :defer t
  :init
  ;; Contacts
  (defun rifle-Contacts-ref ()
    (interactive)
    (let ((my-contacts-reference-dir
           (concat org-directory "/Contacts/")))
      (helm-org-rifle-directories
       (list my-contacts-reference-dir))))

  (unless (boundp 'reference-prefix)
    (define-prefix-command 'reference-prefix))
  (define-key Org-prefix (kbd "r") 'reference-prefix)
  (define-key reference-prefix (kbd "C-c") 'rifle-Contacts-ref))

;;; [ org-vcard ] -- export and import vCards from within Org-mode.

(use-package org-vcard
  :ensure t
  :defer t
  :commands (org-vcard-export org-vcard-import)
  :init (setq org-vcard-append-to-existing-import-buffer t
              org-vcard-append-to-existing-export-buffer t
              org-vcard-include-import-unknowns t))


(provide 'init-org-contacts)

;;; init-org-contacts.el ends here
