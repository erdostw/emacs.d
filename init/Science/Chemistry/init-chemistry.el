;;; init-chemistry.el --- init for Chemistry.

;;; Commentary:



;;; Code:

;;; Chemistry: SMILES
(use-package smiles-mode
  :ensure t
  :ensure-system-package (babel . "sudo pacman -S --noconfirm openbabel")
  :defer t
  :config
  (require 'ob-smiles)
  (add-to-list 'org-babel-load-languages '(smiles . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("smiles" . "smiles"))
  )



(provide 'init-chemistry)

;;; init-chemistry.el ends here
