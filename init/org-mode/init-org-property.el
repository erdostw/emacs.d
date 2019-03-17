;;; init-org-property.el --- init for Org Properties
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; (setq org-use-property-inheritance t)

(add-to-list 'org-default-properties "LOCATION")
(add-to-list 'org-default-properties "CLASS")

(add-to-list 'org-default-properties "COPYRIGHT")
(add-to-list 'org-default-properties "DATE")
(add-to-list 'org-default-properties "TIME")
(add-to-list 'org-default-properties "SOURCE")
(add-to-list 'org-default-properties "AUTHOR")
(add-to-list 'org-default-properties "EMAIL")
(add-to-list 'org-default-properties "URL")

(add-to-list 'org-default-properties "Source-Code")
(add-to-list 'org-default-properties "ISSUE")
(add-to-list 'org-default-properties "Pull-Request")
(add-to-list 'org-default-properties "COMMIT")
(add-to-list 'org-default-properties "CONFIG")
(add-to-list 'org-default-properties "Translation-Chinese")


(provide 'init-org-property)

;;; init-org-property.el ends here
