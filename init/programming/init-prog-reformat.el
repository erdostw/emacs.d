;;; init-prog-reformat.el --- init for reformatters

;;; Time-stamp: <2020-11-30 16:55:38 stardiviner>

;;; Commentary:



;;; Code:

;;; [ reformatter ] -- Define commands which run reformatters on the current buffer.

(use-package reformatter
  :ensure t
  :defer t
  :commands (reformatter-define)
  :config
  (reformatter-define json-format
    :program "jq"
    :args '("--indent" "4"))
  (reformatter-define yapf-format
    :program "yapf")
  (reformatter-define isort-format
    :program "isort"
    :args '("--apply" "-")))

;;; [ prettier ] -- Prettier code formatting for Emacs. $ npm install prettier

;; (use-package prettier
;;   :ensure t
;;   :defer t
;;   :commands (prettier-prettify)
;;   :hook (prog-mode . prettier-mode))



(provide 'init-prog-reformat)

;;; init-prog-reformat.el ends here
