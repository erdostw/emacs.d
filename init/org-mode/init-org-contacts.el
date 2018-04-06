;;; init-org-contacts.el --- init for Org Contacts
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-contacts ] -- Contacts management in Org-mode.

(require 'org-contacts)

(setq org-contacts-files (list (concat org-directory "/Contacts/Contacts.org")))

(setq org-capture-templates
      (append '(("C" "[C]ontact"
                 entry (file (lambda () (car org-contacts-files)))
                 "** %^{NAME}
:PROPERTIES:
:AVATAR: %^{Avatar}
:NICK: %^{Nick}
:NAME(Chinese): %^{Name(Chinese)}
:NAME(English): %^{Name(English)}
:BIRTHDAY:
:GENDER: %^{Gender|Transgender|Male|Female}
:Sexual: %^{Sexual|Heterosexual|Bisexual|Homosexual}
:RELATIONSHIP: %^{Relationship|Internet|Meet|Friend|Good Friend|Boy Friend|Girl Friend|Classmate|Schoolmate}
:FIRST-MEET: %^U  %^{How is the first-time meet? when? where? how?}
:Thought: %^{Thought|open|conservative}
:MOBILE: %^{Mobile Phone}
:EMAIL: %^{Email}
:BLOG: %^{Blog}
:WeChat: %^{WeChat}
:QQ:
:Facebook: %^{Facebook}
:GitHub: %^{GitHub}
:ADDRESS(home): %^{address(home)}
:ADDRESS(work): %^{address(work)}
:ADDRESS(live): %^{address(live)}
:CHARACTER:
:FEELING:
:World-Views:
:LANGUAGES: %^{Languages|Chinese|Chinese, English|English|Japanese|Korean}
:EDUCATION: %^{Education}
:SKILLS: %^{Skills|Programming|Economy}
:Programming-Skills: %^{Programming Skills|Emacs|Web|Computer System|Cloud Computation}
:Programming-Languages: %^{Programming Languages|Lisp|Common Lisp|Clojure|Emacs Lisp|Java|C/C++|Python|Ruby|PHP}
:Occupation: %^{Occupation|Programmer|Freelancer|Businessman|Servant|Arter}
:Hobbies: %^{Hobbies|Reading|Music|Movie|Travel}
:END:"
                 :empty-lines 1
                 :jump-to-captured t
                 )
                )
              org-capture-templates))

;; (add-to-list 'org-property-set-functions-alist
;;              '(".*" . org-completing-read))

(setq org-contacts-matcher
      "NAME<>\"\"|EMAIL<>\"\"|Mailing-List<>\"\"|ALIAS<>\"\"|RELATIONSHIP<>\"\"|PHONE<>\"\"|ADDRESS<>\"\"|BIRTHDAY<>\"\"|PROGRAMMING-SKILLS<>\"\"|SKILLS<>\"\"|EDUCATION<>\"\"|JOBS<>\"\"|NOTE"
      )

;;; avatar
(setq org-contacts-icon-use-gravatar nil
      org-contacts-icon-property "AVATAR")

;; Create agenda view for contacts matching NAME.
(define-key Org-prefix (kbd "M-c") 'org-contacts)

(dolist (hook '(message-mode-hook
                mu4e-compose-mode-hook
                ))
  (add-hook hook 'org-contacts-setup-completion-at-point))


;; (defun org-contacts-properties-drawer-link-workaround ()
;;   "Fix can't open link in properties drawer issue."
;;   (if (string= (expand-file-name (buffer-file-name)) org-contacts-files)
;;       (setq-local org-startup-with-latex-preview nil)))
;; (add-hook 'org-mode-hook 'org-contacts-properties-drawer-link-workaround)

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
  (define-key reference-prefix (kbd "C-c") 'rifle-Contacts-ref)
  )


;;; [ org-vcard ] -- export and import vCards from within Org-mode.

(use-package org-vcard
  :ensure t
  :defer t
  :commands (org-vcard-export org-vcard-import)
  :config
  (setq org-vcard-append-to-existing-import-buffer t
        org-vcard-append-to-existing-export-buffer t)
  (setq org-vcard-include-import-unknowns t)
  )


(provide 'init-org-contacts)

;;; init-org-contacts.el ends here
