;;; init-prog-lang-fortran.el --- init for Fortran -*- lexical-binding: t; -*-

;;; Time-stamp: <2020-11-19 11:10:02 stardiviner>

;;; Commentary:



;;; Code:

;;; [ fortran ] -- Built-in Fortran mode for GNU Emacs.

(use-package fortran
  :defer t
  :mode (("\\.f\\'" . fortran-mode)
         ("\\.f90\\'" . fortran-mode)
         ("\\.f95\\'" . fortran-mode)))



(provide 'init-prog-lang-fortran)

;;; init-prog-lang-fortran.el ends here
