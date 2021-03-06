;;; init-org-tag.el --- init for Org Tags
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


;;; Tags

(setq org-auto-align-tags nil)

(setq org-tag-persistent-alist
      '(("ARCHIVE" . ?A)
        ("noexport" . ?E)
        ("private" . ?P)
        ("deprecated" . ?D)
        ("outdated" . ?O)))

;; auto add tag "comment" for [C-c C-z] add log note.
(add-to-list 'org-tag-persistent-alist '("comment"))
(defun my/org-add-note--auto-add-tag ()
  "Auto add tag 'comment' when add note log."
  (org-back-to-heading)
  ;; remove multiple same "comment" tags
  (autoload 'seq-uniq "seq.el")
  (org-set-tags (seq-uniq (cons "comment" (org-get-tags nil t)))))
(advice-add 'org-add-note :after #'my/org-add-note--auto-add-tag)

;;; for Org Book reading journal. Mark an headline as a book
(add-to-list 'org-tag-persistent-alist '("book" . ?h))
(add-to-list 'org-default-properties "AUTHOR")
(add-to-list 'org-default-properties "PUBLISH_DATE")
(add-to-list 'org-default-properties "PRESS")

(setq org-tag-alist
      '(;; Marks
        (:startgrouptag) ("@marks" . nil) (:grouptags)
        ("on") ("off") ("star") ("like") ("favorite") ("suggested") ("heart") ("smile") ("brain")
        ("check") ("alert") ("important") ("flag") ("error")
        ("label") ("question") ("info") ("quote")
        ("table") ("translate" . ?t) ("language") ("idea" . ?i) ("comment") ("screenshot")
        ("trash") ("delete") ("clear") ("cancel") ("lock") ("unlock") ("key")
        ("refresh") ("repeat") ("shuffle")
        ("1") ("2") ("3") ("4") ("5") ("6") ("7") ("8") ("9") ("10")
        ("book" . ?h) ("bookmark" . ?b) ("note") ("paperclip")
        ("plot") ("diagram") ("chart") ("line_chart") ("area_chart") ("pie_chart")
        ("file") ("archive_file")
        ("word") ("excel") ("powerpoint") ("access") ("slideshow")
        ("document") ("pdf") ("image") ("video") ("audio") ("movie") ("film") ("picture") ("photo") ("music") ("game") ("steam")
        ("camera") ("vlog") ("record") ("mic") ("news")
        ("map") ("map_pin") ("location") ("street_view")
        ("search") ("download") ("upload") ("link") ("email")("rss") ("cloud")
        ("settings") ("save") ("sync") ("backup") ("restore") ("security")
        ("reply") ("send") ("share") ("screen_share") ("cast")
        (:endgrouptag)
        
        ;; Task
        (:startgrouptag) ("@task" . nil) (:grouptags)
        ("event") ("event_available") ("event_busy") ("fragment")
        ("today") ("tomorrow") ("future") ("schedule") ("inprogress") ("timer") ("snooze") ("notification") ("alarm")
        (:endgrouptag)
        
        ;; Life
        (:startgrouptag) ("@life" . nil) (:grouptags)
        ("forum") ("talk") ("call") ("voice_chat")
        ("user") ("contact") ("person") ("person_pin") ("group")
        ("male") ("female") ("neuter") ("venus") ("venus_double") ("venus_mars")
        ("store") ("shopping") ("express")
        ("finance") ("money") ("payment")
        ("credit_card") ("visa") ("mastercard") ("PayPal") ("stripe") ("gratipay")
        ("digital_currency") ("bitcoin") ("btc") ("ethereum")
        ("home") ("weekend") ("repair") ("dining") ("kitchen")
        ("drink") ("coffee") ("bar")
        ("watch") ("hearing") ("headphone")
        ("hospital") ("medical") ("health") ("see_doctor") ("doctor") ("medical") ("healing") ("health")
        ("library") ("bank") ("ATM") ("school")
        ("hotel") ("spa") ("laundry") ("pets") ("florist") ("play") ("city") ("industry")
        ("law") ("government") ("censorship") ("complaint")        
        ("bicycle") ("car") ("traffic") ("parking") ("bus") ("subway") ("railway") ("train") ("tram") ("flight") ("ship") ("run") ("walk") ("travel")
        ("child")
        ("recycle")
        ("daoism") ("tree") ("empire")
        (:endgrouptag)
        
        ;; Work
        (:startgrouptag) ("@work" . ?w) (:grouptags)
        ("appointment" . ?a) ("meeting" . ?m) ("urgent" . ?u)
        ("print") ("business_trip")
        (:endgrouptag)
        
        ;; SEX & Porn
        (:startgrouptag) ("@SEX" . ?X) (:grouptags)
        ("H")
        ("date") ("pickup") ("PUA") ("uncensored")
        ("creampie") ("blowjob") ("orgasm") ("masturbation") ("dildo") ("lick_pussy") ("clit") ("handjob") ("moan")
        ("beauty") ("pretty") ("young") ("handsome") ("beautiful_boy") ("teen") ("girl")
        ("ride_face") ("ride_dick") ("massage") ("shower") ("pillow") ("public") ("naked") ("night")
        ("SM") ("extreme_exhibition") ("car")
        ("anal") ("trans") ("gay") ("couple") ("amateur") ("selfie") ("stealthie") ("live_stream") ("real") ("deepthroat") ("squirt") ("cum")
        ("homemade") ("kitchen") ("pussy") ("cosplay") ("oral") ("female") ("back") ("asian") ("hard")
        ("dog") ("slow_motion") ("erotic") ("oil") ("blonde")
        ("close_up") ("big_cock") ("footjob") ("threesome") ("OL") ("office") ("exchange_student")
        ("scene") ("BBC") ("black_big_cock") ("group") ("foursome")
        ("woman_on_top") ("cowgirl")
        (:endgrouptag)
        
        ;; Devices
        (:startgroup)
        ("hardware") ("computer") ("laptop") ("mobile") ("phone")
        ("router") ("fax") ("scanner") ("TV") ("cmcc") ("robot") ("usb") ("disk") ("WiFi") ("Nvidia")
        (:endgroup)
        
        (:startgrouptag) ("wiki" . ?k) (:grouptags)
        ("thought") ("philosophy") ("psychology") ("literature")
        ("computer_science") ("math")
        ("strategies")
        ("science") ("finance") ("stock") ("business") ("economy")
        ("history") ("politics") ("society")
        ("medicine")
        (:endgrouptag)
        
        (:startgrouptag) ("programming") (:grouptags)
        ("coding") ("code" . ?C) ("source_code") ("bug") ("vulnerability") ("patch") ("diff")
        ("Emacs" . ?e) ("Org" . ?o) ("regex") ("git" . ?G) ("design")
        (:startgroup)
        ("GitHub") ("GitLab")
        ("terminal") ("cloud") ("DevOps") ("docker")
        ("Linux" . ?L) ("Apple") ("macOS") ("Windows" . ?W) ("Android") ("adb") ("iOS")
        ("LISP" . ?l) ("Common_Lisp") ("Clojure" . ?c) ("ClojureScript" . ?s)
        ("Java" . ?j) ("C") ("cpp") ("Go") ("Rust") ("Swift") ("C#" . ?#)
        ("Shell" . ?S) ("Python" . ?p) ("Ruby" . ?r)
        ("Web") ("JavaScript" . ?J) ("HTML") ("HTML5") ("CSS") ("CSS3")
        ("Firefox") ("Chromium") ("Chrome") ("Edge") ("Safari")
        ("database" . ?d) ("SQL") ("PostgreSQL") ("MySQL") ("MariaDB") ("Oracle") ("SQLite") ("DB2")
        ("TeX") ("LaTeX") ("Markdown") ("reStructuredText") ("AsciiDoc") ("YAML") ("TOML") ("CWL")
        ;; Internet
        ("Internet") ("Google") ("Facebook") ("Twitter") ("Microsoft") ("Amazon") ("Mozilla") ("Reddit")
        ("YouTube") ("PornHub") ("Instagram") ("Dribbble") ("Dropbox") ("whatsapp")
        ("Alibaba") ("Baidu") ("Tencent") ("weixin") ("wechat") ("weibo") ("ByteDance") ("Bilibili")
        (:endgroup)
        (:endgrouptag)
        
        (:startgrouptag) ("license") (:grouptags)
        ("license") ("free")
        ("GNU") ("open_source") ("GPL") ("CC")
        (:startgroup)
        ("GNU_General_Public_License_v3") ("GNU_General_Public_License_v2") ("GNU_Affero_General_Public_license") ("GNU_Lesser_General_Public_license") ("MIT_License") ("Apache_License") ("BSD_License") ("Creative_Commons_License") ("Eclipse_Public_License") ("Mozilla_Public_License")
        (:endgroup)
        (:endgrouptag)
        
        (:startgroup)
        (:startgrouptag) ("@family") (:grouptags)
        ("sister") ("father") ("mother")
        (:endgrouptag)
        (:startgrouptag) ("@relative") (:endgrouptag)
        (:startgrouptag) ("@girlfriend") (:endgrouptag)
        (:startgrouptag) ("@workmate") (:endgrouptag)
        (:startgrouptag) ("@friend") (:grouptags)
        ("good_friend") ("friend") ("person_who_knows")
        (:endgrouptag)
        (:endgroup)
        
        (:startgrouptag) ("@project") (:grouptags)
        ("agriculture")
        (:endgrouptag)
        
        (:startgrouptag) ("company") (:grouptags)
        ("users") ("promotion")
        ("accounting") ("copyright") ("registered")
        (:endgrouptag)
        
        (:startgrouptag) ("country") (:grouptags)
        ("afghanistan")
        ("aland_islands")
        ("albania")
        ("algeria")
        ("american_samoa")
        ("andorra")
        ("angola")
        ("anguilla")
        ("antigua_and_barbuda")
        ("argentina")
        ("armenia")
        ("aruba")
        ("australia")
        ("austria")
        ("azerbaijan")
        ("azores_islands")
        ("bahamas")
        ("bahrain")
        ("balearic_islands")
        ("bangladesh")
        ("barbados")
        ("basque_country")
        ("belarus")
        ("belgium")
        ("belize")
        ("benin")
        ("bermuda")
        ("bhutan")
        ("bolivia")
        ("bonaire")
        ("bosnia_and_herzegovina")
        ("botswana")
        ("brazil")
        ("british_columbia")
        ("british_indian_ocean_territory")
        ("british_virgin_islands")
        ("brunei")
        ("bulgaria")
        ("burkina_faso")
        ("burundi")
        ("cambodia")
        ("cameroon")
        ("canada")
        ("canary_islands")
        ("cape_verde")
        ("cayman_islands")
        ("central_african_republic")
        ("ceuta")
        ("chad")
        ("chile")
        ("china")
        ("christmas_island")
        ("cocos_island")
        ("colombia")
        ("comoros")
        ("cook_islands")
        ("corsica")
        ("costa_rica")
        ("croatia")
        ("cuba")
        ("curacao")
        ("cyprus")
        ("czech_republic")
        ("democratic_republic_of_congo")
        ("denmark")
        ("djibouti")
        ("dominica")
        ("dominican_republic")
        ("east_timor")
        ("ecuador")
        ("egypt")
        ("el_salvador")
        ("england")
        ("equatorial_guinea")
        ("eritrea")
        ("estonia")
        ("ethiopia")
        ("european_union")
        ("falkland_islands")
        ("faroe_islands")
        ("fiji")
        ("finland")
        ("france")
        ("french_polynesia")
        ("gabon")
        ("galapagos_islands")
        ("gambia")
        ("georgia")
        ("germany")
        ("ghana")
        ("gibraltar")
        ("greece")
        ("greenland")
        ("grenada")
        ("guam")
        ("guatemala")
        ("guernsey")
        ("guinea_bissau")
        ("guinea")
        ("haiti")
        ("hawaii")
        ("honduras")
        ("hong_kong")
        ("hungary")
        ("iceland")
        ("india")
        ("indonesia")
        ("iran")
        ("iraq")
        ("ireland")
        ("isle_of_man")
        ("israel")
        ("italy")
        ("ivory_coast")
        ("jamaica")
        ("japan")
        ("jersey")
        ("jordan")
        ("kazakhstan")
        ("kenya")
        ("kiribati")
        ("kosovo")
        ("kuwait")
        ("kyrgyzstan")
        ("laos")
        ("latvia")
        ("lebanon")
        ("lesotho")
        ("liberia")
        ("libya")
        ("liechtenstein")
        ("lithuania")
        ("luxembourg")
        ("macao")
        ("madagascar")
        ("madeira")
        ("malawi")
        ("malaysia")
        ("maldives")
        ("mali")
        ("malta")
        ("marshall_island")
        ("martinique")
        ("mauritania")
        ("mauritius")
        ("melilla")
        ("mexico")
        ("micronesia")
        ("moldova")
        ("monaco")
        ("mongolia")
        ("montenegro")
        ("montserrat")
        ("morocco")
        ("mozambique")
        ("myanmar")
        ("namibia")
        ("nauru")
        ("nepal")
        ("netherlands")
        ("new_zealand")
        ("nicaragua")
        ("niger")
        ("nigeria")
        ("niue")
        ("norfolk_island")
        ("north_korea")
        ("northen_cyprus")
        ("northern_marianas_islands")
        ("norway")
        ("oman")
        ("orkney_islands")
        ("ossetia")
        ("otan")
        ("pakistan")
        ("palau")
        ("palestine")
        ("panama")
        ("papua_new_guinea")
        ("peru")
        ("philippines")
        ("pitcairn_islands")
        ("poland")
        ("portugal")
        ("puerto_rico")
        ("qatar")
        ("rapa_nui")
        ("republic_of_macedonia")
        ("republic_of_the_congo")
        ("romania")
        ("russia")
        ("rwanda")
        ("saba_island")
        ("sahrawi_arab_democratic_republic")
        ("saint_kitts_and_nevis")
        ("samoa")
        ("san_marino")
        ("sao_tome_and_principe")
        ("sardinia")
        ("saudi_arabia")
        ("scotland")
        ("senegal")
        ("serbia")
        ("seychelles")
        ("sicily")
        ("sierra_leone")
        ("singapore")
        ("sint_eustatius")
        ("sint_maarten")
        ("slovakia")
        ("slovenia")
        ("solomon_islands")
        ("somalia")
        ("somaliland")
        ("south_africa")
        ("south_korea")
        ("south_sudan")
        ("spain")
        ("sri_lanka")
        ("st_barts")
        ("st_lucia")
        ("st_vincent_and_the_grenadines")
        ("sudan")
        ("suriname")
        ("swaziland")
        ("sweden")
        ("switzerland")
        ("syria")
        ("taiwan")
        ("tajikistan")
        ("tanzania")
        ("thailand")
        ("tibet")
        ("togo")
        ("tokelau")
        ("tonga")
        ("transnistria")
        ("trinidad_and_tobago")
        ("tubalu")
        ("tunisia")
        ("turkey")
        ("turkmenistan")
        ("turks_and_caicos")
        ("uganda")
        ("ukraine")
        ("united_arab_emirates")
        ("united_kingdom")
        ("united_nations")
        ("america")
        ("uruguay")
        ("uzbekistn")
        ("vanuatu")
        ("vatican_city")
        ("venezuela")
        ("vietnam")
        ("virgin_islands")
        ("singapore")
        ("yemen")
        ("zambia")
        ("zimbabwe")
        (:endgrouptag)
        ))

(setq org-tag-faces
      '(("noexport" :foreground "DimGray" :weight bold :underline t :strike-through t)
        ("deprecated" :foreground "DimGray" :strike-through t)
        ("LOG" :foreground "DeepSkyBlue")
        ("private" :foreground "deep pink")
        ("book" :foreground "deep pink")
        ("fragment" :foreground "LightGray" :weight bold)
        ("computer" :foreground "green")
        ("@life" :foreground "black")
        ("@work" :foreground "DeepSkyBlue")
        ("@SEX" :foreground "deep pink" :weight bold)
        ("@Programming" :foreground "lawn green" :weight bold)
        ("Linux" :foreground "yellow" :weight bold)
        ("Mac" :foreground "#444444" :weight bold)
        ("Emacs" :foreground "dodger blue" :weight bold)
        ("Org" :foreground "green yellow" :weight bold)
        ("Hacker" :foreground "OrangeRed" :weight bold)
        ("LISP" :foreground "deep pink" :weight bold)
        ("Common_Lisp" :foreground "sky blue" :weight bold)
        ("Clojure" :foreground "sky blue" :weight bold)
        ("ClojureScript" :foreground "sky blue" :weight bold)
        ("Python" :foreground "yellow" :weight bold)
        ("Ruby" :foreground "red" :weight bold)
        ("Shell" :foreground "sea green")
        ("Java" :foreground "royal blue" :weight bold)
        ("C" :foreground "SaddleBrown" :weight bold)
        ("Go" :foreground "gold" :weight bold)
        ("Rust" :foreground "WhiteSmoke" :weight bold)
        ("JavaScript" :foreground "yellow" :weight bold)))

;; ;;; `org-archive-tag', `org-archived'
;; (defconst org-deprecated-tag "deprecated"
;;   "The tag that marks a subtree as archived.
;; An archived subtree does not open during visibility cycling, and does
;; not contribute to the agenda listings.")
;;
;; (defface org-deprecated '((t :inherit shadow))
;;   "Face for headline with the deprecated tag."
;;   :group 'org-faces)

;;; [ org-pretty-tags ] -- Surrogates for Org tags.

(use-package org-pretty-tags
  :ensure t
  :defer t
  :after org
  :delight org-pretty-tags-mode
  :init (setq org-tag-faces nil)
  :hook (after-init . org-pretty-tags-global-mode))


(provide 'init-org-tag)

;;; init-org-tag.el ends here
