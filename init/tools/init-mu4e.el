;;; init-mu4e.el --- init for mu4e.

;;; Commentary:




;;; Code:

(use-package mu4e
  ;; from Linux package
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; compile from git
  ;; :load-path (expand-file-name "~/Code/Emacs/mu/mu/mu4e")
  :init
  (require 'mu4e)
  (require 'mu4e-contrib)

  (require 'mu4e-main)
  (require 'mu4e-vars)
  (require 'mu4e-proc)
  (require 'mu4e-speedbar)
  :config
  ;; (setq mu4e-mu-home nil ; nil for default
  ;;       mu4e-mu-binary "/usr/sbin/mu"
  ;;       )

  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-compose-in-new-frame t)

  ;; Helm sources for searching emails and contacts using mu.
  (use-package helm-mu
    :ensure t
    :config
    ;; Use helm-mu instead of mu4e's search
    (define-key mu4e-main-mode-map "s" 'helm-mu)
    (define-key mu4e-headers-mode-map "s" 'helm-mu)
    (define-key mu4e-view-mode-map "s" 'helm-mu)
    ;; By the way, enabling `helm-follow-mode' via [C-c C-f] allows to preview
    ;; emails as you search.
    )
  )


;; a list of user's e-mail addresses
(setq mu4e-user-mail-address-list
      '("numbchild@gmail.com" "348284894@qq.com"))


;; [ Maildir ]
(setq mu4e-maildir "~/Mails"       ; top-level Maildir
      mu4e-sent-folder "/Send"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder "/Trash"
      ;; mu4e-refile-folder "/Archives"
      )
;; (i.e.. /home/user/Maildir/sent must exist)
(unless (file-exists-p mu4e-maildir)
  (make-directory mu4e-maildir))
(unless (file-exists-p (concat mu4e-maildir mu4e-sent-folder))
  (make-directory (concat mu4e-maildir mu4e-sent-folder)))
(unless (file-exists-p (concat mu4e-maildir mu4e-drafts-folder))
  (make-directory (concat mu4e-maildir mu4e-drafts-folder)))
(unless (file-exists-p (concat mu4e-maildir mu4e-trash-folder))
  (make-directory (concat mu4e-maildir mu4e-trash-folder)))

;; the maildirs you use frequently; access them with 'j' ('jump')
(setq mu4e-maildir-shortcuts '(("/INBOX"       . ?i)
                               ("/Send"        . ?s)
                               ("/Drafts"      . ?d)
                               ("/Trash"       . ?t)
                               ("/Work"        . ?w)
                               ("/Emacs/help"  . ?e)
                               ("/Emacs/Org-mode" . ?g)
                               ("/Lisp/comp-lang" . ?l)
                               ("/Clojure"        . ?c)
                               ))


;; Get Mail, Update -- [U]
;; program to get mail; alternatives are 'fetchmail', 'getmail'
;; isync or your own shellscript.
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 1800
      mu4e-hide-index-messages t)

;; Send Mail

;; SMTP
;; (require 'smtpmail)
;; (setq
;;  message-send-mail-function   'smtpmail-send-it
;;  smtpmail-default-smtp-server "smtp.example.com"
;;  smtpmail-smtp-server         "smtp.example.com"
;;  smtpmail-local-domain        "example.com")

;; send-mail program
;; tell message-mode how to send mail
;; - `smtpmail-send-it'
;; - `message-send-mail-with-mailclient'
;; - `message-send-mail-with-sendmail'

;; 0: [sendmail]
(setq message-send-mail-function 'message-send-mail-with-sendmail)

;; $ sendmail -q
;; $ sendmail -oem -oi
(setq sendmail-program "/usr/sbin/sendmail")

;; 1: msmtp
;; (setq sendmail-program "/usr/bin/msmtp")
;; $ msmtp -C $HOME/.mutt/msmtprc

;; 2: smtpmail
;; (setq message-send-mail-function 'smtpmail-send-queued-mail)
;; (setq message-send-mail-function 'smtpmail-send-it)

;; (setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "numbchild@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       ;; smtpmail-local-domain        "example.com"
;;       )

;; Queuing mail
;; you can queue the mail, and send it when you have restored your internet connection.
;; (setq smtpmail-queue-mail t  ;; start in non-queuing mode
;;       smtpmail-queue-dir  "~/Mails/queue/cur" ; send with `smtpmail-send-queued-mail'
;;       smtpmail-queue-index "~/Mails/queue/index"
;;       smtpmail-queue-index-file "index"
;;       )


;; two: [smtp] for Gmail
;; (require 'smtpmail)

;; 1.
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "numbchild@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       ;; queue offline mode.
;;       smtpmail-queue-mail nil             ; start in non-queuing mode.
;;       smtpmail-queue-dir "~/Mails/queue/cur")

;; 2.
;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'starttls
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)


;; [ View ]

(setq mu4e-split-view 'horizontal ; 'vertical, 'horizontal
      mu4e-headers-visible-lines 13
      mu4e-headers-visible-columns 30
      mu4e-headers-show-threads t
      mu4e-headers-auto-update t
      mu4e-use-fancy-chars t
      ;; email prefix marks
      mu4e-headers-new-mark '("N" . " ")
      mu4e-headers-unread-mark '("u" . "·") ; · • ∘ ☐
      mu4e-headers-seen-mark '("S" . " ") ; ☑ ☒ ⊟ ⊠ ⊡ ▣ ⋄
      mu4e-headers-signed-mark '("s" . "✔")
      mu4e-headers-encrypted-mark '("x" . "⚴")
      mu4e-headers-draft-mark '("D" . "✎")
      mu4e-headers-attach-mark '("a" . "◘")
      mu4e-headers-passed-mark '("P" . "❯")
      mu4e-headers-flagged-mark '("F" . "★") ; ⚑ ★ ☆ ✪ ✾ ✿ ❀
      mu4e-headers-replied-mark '("R" . "⏎") ; ⏎
      mu4e-headers-trashed-mark '("T" . "✗")
      ;; thread prefix marks
      mu4e-headers-default-prefix '("|" . "➘")
      mu4e-headers-has-child-prefix '("+" . "⌊") ; ┝
      mu4e-headers-empty-parent-prefix '("-" . "∠")
      mu4e-headers-first-child-prefix '("\\" . "╲") ; ↳ ⌊ ↘ ➘ ╲
      mu4e-headers-duplicate-prefix '("=" . "‡")
      )


;; [ Message ]

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:

(setq mu4e-headers-date-format "%x %X")

;; normal fields
;; (setq mu4e-headers-fields
;;       '((:flags   .  6)
;;         (:subject . 65)
;;         (:from    . 15)
;;         (:date    . 20))
;;       )

;; only show thread subject once
(setq mu4e-headers-fields
      '((:flags .  6)
        (:human-date  . 18)
        (:from  . 18)
        (:thread-subject . nil)
        ;; (:subject . nil)
        )
      )

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-compose-reply-to-address "numbchild@gmail.com"
      user-mail-address "numbchild@gmail.com"
      user-full-name  "stardiviner")


;; [ Compose ]

;; Compose hooks [mu4e-compose-pre-hook, mu4e-compose-mode-hook]
;;
;; When replying to an email I want to use the address I received this message
;; to as the sender of the reply. This is fairly trivial:
;;
;; - mu4e-compose-pre-hook:
;;       this hook is run before composition starts; if you are composing a reply, forward a message, or edit an existing message, the variable mu4e-compose-parent-message points to the message being replied to, forwarded or edited, and you can use mu4e-message-field to get the value of various properties
;; - mu4e-compose-mode-hook:
;;       this hook is run just before composition starts, when the whole buffer has already been set up. This is a good place for editing-related settings. mu4e-compose-parent-message (see above) is also at your disposal. mu4e-compose-mode-hook is especially useful for editing-related settings.

;; suppose we want to set the From:-address for a reply message based on the
;; receiver of the original:

;; (add-hook 'mu4e-compose-pre-hook
;;           (defun my-mu4e-set-from-address ()
;;             "Set the From: address based on the To: address of the original."
;;             (let ((msg mu4e-compose-parent-message)) ; msg is shorter...
;;               (setq user-mail-address
;;                     (cond
;;                      ((mu4e-message-contact-field-matches msg :to "348284894@qq.com")
;;                       "348284894@qq.com")
;;                      ((mu4e-message-contact-field-matches msg :to "blackredwhore@gmail.com")
;;                       "blackredwhore@gmail.com")
;;                      (t "numbchild@gmail.com")))
;;               )))


;; include in message with C-c C-w
(setq mu4e-compose-signature-auto-include nil
      mu4e-compose-signature
      "[ stardiviner ] I want to save myself from this world.
       IRC(freenode): stardiviner     \\ Google+:  numbchild \\
       https://stardiviner.github.io/
      "
      )

;; compose address complete with [M-Tab].
(setq mu4e-compose-complete-addresses t ; e-mail address auto completion
      ;; to limit completion pool, filter mailing list addresses and like.
      mu4e-compose-complete-only-personal nil
      mu4e-compose-complete-ignore-address-regexp "no-?reply"
      mu4e-compose-keep-self-cc t ; keep myself on the Cc: list.
      ;; mu4e-compose-complete-only-after
      )

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;;  [ Reply ]

;; don't include self (that is, any member of `mu4e-user-mail-address-list') in
;; replies.
(setq mu4e-compose-dont-reply-to-self nil)

(define-key mu4e-headers-mode-map (kbd "r") 'mu4e-compose-reply)
(define-key mu4e-headers-mode-map (kbd "R") 'mu4e-headers-mark-for-refile)
(define-key mu4e-view-mode-map (kbd "r") 'mu4e-compose-reply)
(define-key mu4e-view-mode-map (kbd "R") 'mu4e-view-mark-for-refile)

;; reply only to thread: header `Reply-to:', `List-Post:'
;; - `mu4e~draft-reply-construct'


;; [ Sign ]

;; Signing and encrypting It's possible using emacs-mime, most easily accessed
;; through the Attachments-menu while composing a message, or with M-x
;; mml-secure-message-encrypt-pgp, M-x mml-secure-message-sign-pgp.  The support
;; for encryption and signing is independent of the support for their
;; counterparts, decrypting and signature verification. Even if your mu4e does
;; have support for the latter two, you can still sign/encrypt messages.

;; - [C-c C-m C-e] :: (mml-secure-message-sign-encrypt)
;;    This will add a tag at the beginning of the mail.
;;    <#secure method=pgpmime mode=signencrypt>
;;    the `mode=signencrypt' means:
;;      - `sign'
;;      - `encrypt'


;; message inline pgp sign.
;; `message-send-hook' or `mu4e-compose-mode-hook'
;; `mml-secure-message-sign-pgpauto' or `mml-secure-message-sign-pgpmime'

(add-hook 'message-send-hook 'mml-secure-message-sign-pgpauto)
;; (add-hook 'mu4e-compose-mode-hook 'mml-secure-message-sign-pgpauto)


;; [ Encrypt ]

;; encrypt outgoing message.
(require 'epg-config)

(require 'mml2015)
(setq mml2015-use 'epg
      epg-user-id "5AE89AC3"
      mml-secure-openpgp-encrypt-to-self t
      mml-secure-openpgp-sign-with-sender t
      )

;; (add-hook 'message-send-hook 'mml-secure-message-encrypt-pgpauto)
;; (add-hook 'mu4e-compose-mode-hook 'mml-secure-message-encrypt-pgpauto)


;; [ Headers ] -- `mu4e-header-info'.
(setq mu4e-headers-auto-update t
      mu4e-headers-skip-duplicates t
      )

(define-key mu4e-headers-mode-map (kbd "N") 'mu4e-headers-next-unread)

;; `mu4e-header-info-custom'
;; (add-to-list 'mu4e-header-info-custom
;;              '(:recipnum :name "Number of recipients" :shortname "Recip#" :help "Number of recipients for this message" :function
;;                          (lambda
;;                            (msg)
;;                            (format "%d"
;;                                    (+
;;                                     (length
;;                                      (mu4e-message-field msg :to))
;;                                     (length
;;                                      (mu4e-message-field msg :cc)))))))

;; TODO: make use of flag: list.

;; [ Search ] -- [s]  [:references [regexp]] in search query.

;; result is:   -> :References : nil
(add-to-list 'mu4e-header-info-custom
             '(:references :name "References"
                           :shortname "References"
                           :help "Reference of this thread"
                           :function
                           (lambda
                             (msg)
                             (format "%s"
                                     (mu4e-message-field msg :References)))))

;; (add-to-list 'mu4e-header-info-custom
;;              '(:reply2mythread :name "My thread smart choose depend on References"
;;                                :shortname "My Thread"
;;                                :help "Emails which reply to the thread I created"
;;                                :function
;;                                (lambda
;;                                  (msg)
;;                                  (string-match-p ".*@[HOSTNAME]"
;;                                                  (format "%s"
;;                                                          (mu4e-message-field msg :References)))
;;                                  )))

;; `mu4e-headers-custom-markers'

;; example
;; (add-to-list 'mu4e-headers-custom-markers
;;              '("More than n recipients"
;;                (lambda (msg n)
;;                  (> (+ (length (mu4e-message-field msg :to))
;;                        (length (mu4e-message-field msg :cc))) n))
;;                (lambda ()
;;                  (read-number "Match messages with more recipients than: ")))
;;              t)

;; reply to my thread
(add-to-list 'mu4e-headers-custom-markers
             '("Reply to my thread"
               (lambda (msg reply2mythread)
                 (string-match-p ".*stardiviner"
                                 (mu4e-msg-field msg :References)))
               (lambda nil
                 (message "Messages replied to your thread.")))
             t)


;; [ spam ]

;; from `mu4e-contrib'
(add-to-list 'mu4e-headers-actions
             '("sMark as spam" . mu4e-register-msg-as-spam) t)
(add-to-list 'mu4e-headers-actions
             '("hMark as ham" . mu4e-register-msg-as-ham) t)
(add-to-list 'mu4e-headers-actions
             '("aMark unsure as spam" . mu4e-mark-unsure-as-spam) t)
(add-to-list 'mu4e-headers-actions
             '("bMark unsure as ham" . mu4e-mark-unsure-as-ham) t)

(add-to-list 'mu4e-view-actions
             '("sMark as spam" . mu4e-register-msg-as-spam) t)
(add-to-list 'mu4e-view-actions
             '("hMark as ham" . mu4e-register-msg-as-ham) t)
(add-to-list 'mu4e-view-actions
             '("aMark unsure as spam" . mu4e-mark-unsure-as-spam) t)
(add-to-list 'mu4e-view-actions
             '("bMark unsure as ham" . mu4e-mark-unsure-as-ham) t)


;; creating org-mode links from mu4e messages.
;;
;; - [M-x org-store-link] / [C-c C-l] -- store link to org-mode.
;; - [C-c C-l] -- in org file, you can insert upper stored link into org file.
;;
;; It can be useful to include links to e-mail messages or even search queries
;; in your org-mode files. mu4e supports this with the org-mu4e module; you can
;; set it up by adding it to your configuration:

(require 'org-mu4e)

;; store link to message if in "header view", not to "header query"
(setq org-mu4e-link-query-in-headers-mode nil)

;; - `org-mu4e-open' :: open the mu4e message (for paths starting with 'msgid:')
;;                      or run the query (for paths starting with 'query:').

(defalias 'org-email-open 'org-mu4e-open)

(org-link-set-parameters "email-msgid" 'org-email-open)
(org-link-set-parameters "email-query" 'org-email-open)



;; Sort order and threading
;; - O -- sort. mu4e-headers-change-sorting
;; - P -- toggle threading
;; By default, mu4e sorts messages by date, in descending order: the most recent
;; messages are shown at the top.
;; In addition, the messages are threaded, i.e., shown in the context of a
;; discussion thread; this also affects the sort order.

;; (mu4e-headers-toggle-threading) ; toggle threading. (P)

;; add find relative on same thread search to mu4e actions. [a/A]
(defun my/mu4e-view-related-search (msg)
  "Search `MSG' for related messages to the current one."
  (let* ((msgid (mu4e-msg-field msg :message-id)))
    (switch-to-buffer "*mu4e-headers*")
    (setq mu4e-headers-include-related t)
    (mu4e-headers-search (concat "\"msgid:" msgid "\""))))

(add-to-list 'mu4e-headers-actions '("related thread" . my/mu4e-view-related-search) t)
(add-to-list 'mu4e-view-actions '("relative thread" . my/mu4e-view-related-search) t)


;; [ Message view ]
(setq mu4e-view-fields '(:from :to :cc
                               :subject
                               :date
                               :flags
                               :maildir
                               :attachments
                               ;; :mailing-list
                               :references
                               ;; :tags
                               :signature
                               :decryption
                               )
      ;; show e-mail address after names of contacts From: field. or press [M-RET] to view.
      mu4e-view-show-addresses t
      )
(setq mu4e-view-scroll-to-next nil
      mu4e-split-view 'horizontal ; split view
      )


;; [ Cite ]

;; mu-cite
;; [C-c h] to toggle hide cited.
(add-hook 'mu4e-view-mode-hook 'mu4e-view-toggle-hide-cited)

;; message-cite
(setq message-cite-style message-cite-style-gmail)


;; viewing images inline
;;
;; It is possible to show images inline in the message view buffer if you run
;; emacs in GUI-mode. You can enable this by setting the variable
;; mu4e-view-show-images to t. Since emacs does not always handle images
;; correctly, this is not enabled by default. If you are using emacs 24 with
;; ImageMagick1 support, make sure you call imagemagick-register-types in your
;; configuration, so it is used for images.
;; enable inline images
;; attempt to show images when viewing messages
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 400)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))


;; Displaying rich-text messages
;;
;; mu4e normally prefers the plain-text version for messages that consist of
;; both a plain-text and html (rich-text) versions of the body-text. You change
;; this by setting mu4e-view-prefer-html to t.
(setq mu4e-view-prefer-html nil)

;;; 'html2text, "html2text -utf8 -width 72"
;; (setq mu4e-html2text-command 'html2text)
;; (setq mu4e-html2text-command "html2text -utf8 -width 72 | iconv -t utf-8")
;; (setq mu4e-html2text-command "pandoc -f html -t org | iconv -t utf-8") ; add utf-8 option.

(setq mu4e-html2text-command 'mu4e-shr2text)


;;; Attachments

;; - A -- action to pick some custom action to perform on current message/attachment.
;; - w -- open-with
;; - | -- pipe
;; - e -- open in emacs
;; By default, mu4e uses the xdg-open-program 1 or (on MacOS) the open program
;; for opening attachments. If you want to use another program, you do so by
;; setting the MU_PLAY_PROGRAM environment variable to the program to be used.

(setq mu4e-attachment-dir "~/Downloads"
      mu4e-view-attachment-actions '(("wopen-with" . mu4e-view-open-attachment-with)
                                     ("ein-emacs" . mu4e-view-open-attachment-emacs)
                                     ("|pipe" . mu4e-view-pipe-attachment))
      ;; [C-u e] saving multiple attachments asks once for a directory and saves
      ;; all attachments in the chosen directory.
      mu4e-save-multiple-attachments-without-asking t
      )


;;; Actions

;; - a -- (for messages)
;; - A -- mu4e-headers-action (for attachments)
;;
;; mu4e lets you define custom actions for messages in the Headers view and for
;; both messages and attachments in the Message view. Custom actions allow you
;; to easily extend mu4e for specific needs – for example, marking messages as
;; spam in a spam filter or applying an attachment with a source code patch.

;; (setq mu4e-headers-actions
;;       '(("capture message" . mu4e-action-capture-message)
;;         )
;;       )
;; (setq mu4e-view-actions
;;       '(("capture message" . mu4e-action-capture-message)
;;         ("view as pdf" . mu4e-action-view-as-pdf)))
;; (setq mu4e-view-attachment-actions
;;       '(("wopen-with" . mu4e-view-open-attachment-with)
;;         ("ein-emacs" . mu4e-view-open-attachment-emacs)
;;         ("|pipe" . mu4e-view-pipe-attachment)))

;;; adding an action to actions list.
(defun show-number-of-recipients (msg)
  "Display the number of recipients for the MSG at point."
  (message "Number of recipients: %d"
           (+ (length (mu4e-message-field msg :to))
              (length (mu4e-message-field msg :cc)))))
;; (add-to-list 'mu4e-headers-actions
;;              '("Number of recipients" . show-number-of-recipients) t)
;; search for messages by the sender of the message at point:
(defun search-for-sender (msg)
  "Search for messages sent by the sender of the MSG at point."
  (mu4e-headers-search
   (concat "from:" (cdar (mu4e-message-field msg :from)))))
;; define 'x' as the shortcut
;; (add-to-list 'mu4e-view-actions
;;              '("xsearch for sender" . search-for-sender) t)



;;; Searching
;; - Q -- search. mu4e-headers-toggle-full-search.
;;
;; mu4e is fully search-based: even if you 'jump to a folder', you are executing
;; a query for messages that happen to have the property of being in a certain
;; folder.
;;
;; Normally, queries return up to mu4e-headers-results-limit (default: 500)
;; results. That is usually more than enough, and makes things significantly
;; faster. Sometimes, however, you may want to show all results; you can enable
;; this with M-x mu4e-headers-toggle-full-search, or by customizing the variable
;; mu4e-headers-full-search. This applies to all search commands.

(setq mu4e-headers-full-search nil) ; whether show all search results. or depend on `mu4e-headers-results-limit'.
(setq mu4e-headers-results-limit 1000)

;;; Including related messages
;;
;; It can be useful to not only show the messages that directly match a certain
;; query, but also include messages that are related to these messages. That is,
;; messages that belong to the same discussion thread are included in the
;; results, just like e.g. Gmail does it. You can enable this behavior by
;; setting mu4e-headers-include-related to t, and you can toggle between
;; including/not-including with <W>.
(setq mu4e-headers-include-related t)


;;; Compose

;; - `org-mu4e-compose-org-mode' ::


;;; Send

(setq mu4e-sent-messages-behavior 'sent)


;;; Crypto (signing, encrypting, verifying, decrypting)
;;; - v -- see the details of the signature verification by activating the Details.
;; start gpg-agent manually:
;; $ eval $(gpg-agent --daemon)
(setq mu4e-auto-retrieve-keys t
      mu4e-decryption-policy t          ; auto decrypt.
      )


;;; Refiling

;; - r -- refiling, mu4e-refile-folder

(setq mu4e-refile-folder                ; dynamic refiling
      (lambda (msg)
        (cond
         ;; mu discuss Google Groups
         ((mu4e-message-contact-field-matches msg
                                              :to "mu-discuss@googlegroups.com")
          "/Emacs/mu")
         ;; delete all Cron getmail error messages which is network
         ;; unavailable error.
         ((string-match "Cron .* getmail.*"
                        (or (mu4e-message-field msg :subject) ""))
          ;; (mu4e-message-contact-field-matches msg :from "Cron Daemon")
          "/Trash")
         ;; everything else goes to /archive
         ;; *important* to have a catch-all at the end!
         (t "/archive")
         )))


;;; Bookmarks

;; - [b] :: bookmark
;; - [B] :: edit bookmark before jump/invoking.

;; - B -- mu4e-headers-search-bookmark-edit, which lets you edit the bookmarked query before invoking it.
;; (setq mu4e-bookmarks
;;       '(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
;;         ("date:today..now" "Today's messages" ?t)
;;         ("date:7d..now" "Last 7 days" ?w)
;;         ("mime:image/*" "Messages with images" ?p)))
(setq mu4e-bookmarks
      '(("size:5M..500M"                 "Big messages"       ?b)
        ("date:today..now"               "Today's messages"     ?d)
        ("date:today..now flag:unread"   "Today's unread messages" ?n)
        ("date:1w..now"                  "This week's messages" ?w)
        ("maildir:/Emacs/help"           "Emacs mailbox" ?e)
        ))

(defun mu4e-new-mail-alert ()
  "The mu4e new email alert."
  (interactive)
  (shell-command
   (concat "mpv "
           (getenv "HOME")
           "/Music/Sounds/Ingress/Speech/speech_incoming_message.ogg"
           " &> /dev/null"))
  )
(add-hook 'mu4e-index-updated-hook 'mu4e-new-mail-alert)


;;; Faces

;; current select line
(set-face-attribute 'mu4e-header-highlight-face nil
                    :inherit nil
                    :background (cl-case (alist-get 'background-mode (frame-parameters))
                                  ('light
                                   (color-darken-name (face-background 'default) 10))
                                  ('dark
                                   (color-darken-name (face-background 'default) 5)))
                    ;; 1. Sci-Fi cyan
                    ;; :background "#004A5D" :foreground "white"
                    ;; :box '(:color "cyan" :line-width -1)
                    ;; :weight 'normal :underline nil
                    ;; 2.
                    ;; :background "#004A5D" :foreground "white"
                    ;; :box '(:color "#005D5E" :line-width -1)
                    ;; :weight 'normal
                    )
;;; highlighted email, main view key color like "[q]uit mu4e".
(set-face-attribute 'mu4e-highlight-face nil
                    :foreground "cyan" :background "#073642")
;;; face for things that are ok.
(set-face-attribute 'mu4e-ok-face nil
                    :foreground "forest green"
                    :box '(:color "forest green" :line-width 1 :style nil)
                    )
;;; moved
(set-face-attribute 'mu4e-moved-face nil
                    :foreground "dark gray" :background "dim gray"
                    )
;;; draft (my draft), my sent mail.
(set-face-attribute 'mu4e-draft-face nil
                    :foreground "sky blue"
                    )
;;; Emacs mu4e window top title.
(set-face-attribute 'mu4e-title-face nil
                    :inherit nil
                    :foreground "yellow")
;;; readed mail line in index.
(set-face-attribute 'mu4e-header-face nil
                    :foreground "dim gray")
;; modeline face
(set-face-attribute 'mu4e-modeline-face nil
                    :weight 'bold)
;;; footer
(set-face-attribute 'mu4e-footer-face nil
                    :foreground "deep sky blue")
;;; unread email
(set-face-attribute 'mu4e-unread-face nil
                    :foreground "forest green"
                    :weight 'normal)
(set-face-attribute 'mu4e-system-face nil
                    :foreground "white")
;;; trash email
(set-face-attribute 'mu4e-trashed-face nil
                    :strike-through "black")
;;; level 1 cited (quoted email content)
(set-face-attribute 'mu4e-cited-1-face nil
                    :foreground "cyan")
(set-face-attribute 'mu4e-cited-2-face nil
                    :foreground "dark cyan")
(set-face-attribute 'mu4e-cited-3-face nil
                    :foreground "forest green")
(set-face-attribute 'mu4e-cited-4-face nil
                    :foreground "gold")
(set-face-attribute 'mu4e-cited-5-face nil
                    :foreground "white")
(set-face-attribute 'mu4e-cited-6-face nil
                    :foreground "light blue")
(set-face-attribute 'mu4e-cited-7-face nil
                    :foreground "light green")
;;; warning
(set-face-attribute 'mu4e-warning-face nil
                    :box '(:color "red" :line-width 1)
                    :background "dark red"
                    :foreground "white")
;;; flagged email
(set-face-attribute 'mu4e-flagged-face nil
                    :foreground "white" :background "deep pink"
                    :weight 'bold
                    )
;;; replied email
(set-face-attribute 'mu4e-replied-face nil
                    :foreground "orange"
                    :overline "orange red")
;; forwarded email
(set-face-attribute 'mu4e-forwarded-face nil
                    :foreground "saddle brown"
                    :overline "dark magenta")
;; compose
(set-face-attribute 'mu4e-compose-header-face nil
                    :foreground "cyan"
                    :weight 'bold)
;; -- text follows this line -- where following Org-mode message body.
(set-face-attribute 'mu4e-compose-separator-face nil
                    :foreground "red")
;;; link
(set-face-attribute 'mu4e-link-face nil
                    :underline '(:style line)
                    )
;;; contact: e.g. Christopher Miles, help-gnu-emacs@gnu.org
(set-face-attribute 'mu4e-contact-face nil
                    :foreground "yellow green"
                    ;; :underline "dim gray"
                    )
;;; header-
;;; header field keys: e.g. From:, To:, Subject:,
;; some keys.
(set-face-attribute 'mu4e-header-key-face nil
                    :foreground "chocolate"
                    )
(set-face-attribute 'mu4e-header-marks-face nil
                    :foreground "light blue"
                    )
(set-face-attribute 'mu4e-header-title-face nil
                    :foreground "white"
                    )
(set-face-attribute 'mu4e-header-value-face nil
                    :foreground "dark gray"
                    )
(set-face-attribute 'mu4e-special-header-value-face nil
                    :foreground "brown"
                    :weight 'bold
                    )
;; header names: like From: Subject: etc.
(set-face-attribute 'message-header-name nil
                    :foreground "cyan" :background "black"
                    :box '(:color "#333333" :line-width -1)
                    :weight 'bold)
;; Subject: value
(set-face-attribute 'message-header-subject nil
                    :foreground "cyan"
                    :weight 'bold
                    :underline t)
;; To: value
(set-face-attribute 'message-header-to nil
                    :foreground "white")
;; other header values
(set-face-attribute 'message-header-other nil
                    :foreground "#888888")


;;; Marking

(define-key mu4e-headers-mode-map (kbd "f") 'mu4e-headers-mark-for-flag)
(define-key mu4e-headers-mode-map (kbd "m") 'mu4e-headers-mark-for-something)
(define-key mu4e-headers-mode-map (kbd "M") 'mu4e-headers-mark-for-move)


;;; Add Org-mode structure support for Emails

(add-hook 'mu4e-view-mode-hook
          (lambda ()
            (turn-on-orgstruct) ; Org-struct minor mode
            (turn-on-orgstruct++)
            ;; enable Orgtbl minor mode in message-mode.
            (turn-on-orgtbl)))


;;; Gmail
;; (setq mu4e-maildir "~/Maildir")
;; (setq mu4e-drafts-folder "/[Gmail].Drafts")
;; (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
;; (setq mu4e-trash-folder  "/[Gmail].Trash")
;; (setq mu4e-send-mail-function 'smtpmail-send-it)
;; (setq smtpmail-smtp-server "smtp.gmail.com")
;; (setq mu4e-sent-messages-behavior 'delete)
;; (setq mu4e-maildir-shortcuts
;;       '( ("/INBOX"               . ?i)
;;          ("/[Gmail].Sent Mail"   . ?s)
;;          ("/[Gmail].Trash"       . ?t)
;;          ("/[Gmail].All Mail"    . ?a)))
;; (setq mu4e-get-mail-command "offlineimap")
;; (require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "USERNAME@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)
;; ;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'starttls
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)


;;; Contacts

(add-hook
 'mu4e-compose-mode-hook
 (lambda ()
   (setq-local completion-at-point-functions
               '(mu4e~compose-complete-contact
                 mail-completion-at-point-function
                 message-completion-function))))



(defun my-mu4e-jump-to-index ()
  "User helper function to jump to index."
  (interactive)
  (if (not (mu4e-running-p))
      (mu4e)
    (mu4e-headers-search "maildir:/INBOX"))
  )

(setq mu4e-completing-read-function 'completing-read)

;; [ mu4e-maildirs-extension ]

;; - u :: update the index
;; - C-u u :: only clear the cache
;; - C-u C-u u :: clear the cache and refresh

(use-package mu4e-maildirs-extension
  :ensure t
  :config
  (mu4e-maildirs-extension)

  (set-face-attribute 'mu4e-maildirs-extension-maildir-face nil
                      :foreground "dim gray")
  (set-face-attribute 'mu4e-maildirs-extension-maildir-hl-face nil
                      :foreground "lime green")

  ;; (setq mu4e-maildirs-extension-custom-list )
  (setq mu4e-maildirs-extension-maildir-default-prefix "┝") ; "|"
  )


;; [ mu4e-speedbar ]

;; (add-hook 'mu4e-main-mode-hook 'sr-speedbar-open)


;; maintaining an address-book with org-contacts
;; Usage:
;; - <a o> in headers view & message view :: using the org-capture mechanism.

(setq mu4e-org-contacts-file 'org-contacts-files) ; <full-path-to-your-org-contacts-file>
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)


;; [ mu4e-alert ] -- Desktop notifications and modeline display for mu4e.
(use-package mu4e-alert
  :ensure t
  :config
  (mu4e-alert-set-default-style 'libnotify)
  ;; disable mu4e-alert desktop libnotify notifications.
  ;; (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
  (mu4e-alert-enable-mode-line-display)
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread"
         " AND NOT flag:trashed"
         ;; " AND NOT maildir:"
         "AND references: t"
         ))
  )

;; A library to provide MIME features.
(use-package mu-cite
  :ensure t)




(provide 'init-mu4e)

;;; init-mu4e.el ends here
