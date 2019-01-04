;;; init-docker.el --- init for Docker
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ docker ] -- Emacs interface to Docker.

(use-package docker
  :ensure t
  :ensure-system-package docker
  :defer t
  :bind (:map container-prefix
              ("c" . docker-containers)
              ("i" . docker-images)
              ("v" . docker-volumes)
              ("n" . docker-networks))
  :init (setq docker-containers-show-all t)

  (defun docker-container-insert-name ()
    "A helper function to insert container ID or name."
    (interactive)
    (insert (funcall-interactively 'docker-container-read-name)))
  (define-key container-prefix (kbd "M-i") #'docker-container-insert-name)

  (add-to-list 'display-buffer-alist
               '("\\*docker-images\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("\\*docker-containers\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("\\*docker-machines\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("\\*docker-volumes\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected)))
  (add-to-list 'display-buffer-alist
               '("\\*docker-networks\\*" .
                 (display-buffer-reuse-window display-buffer-below-selected)))
  
  (add-to-list 'all-the-icons-mode-icon-alist
               '(docker-images-mode all-the-icons-fileicon "dockerfile" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(docker-containers-mode all-the-icons-fileicon "dockerfile" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(docker-machines-mode all-the-icons-fileicon "dockerfile" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(docker-volumes-mode all-the-icons-fileicon "dockerfile" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(docker-networks-mode all-the-icons-fileicon "dockerfile" :height 1.0 :v-adjust 0.0))

  :config
  ;; enable global docker minor mode
  (docker-global-mode 1))

;;; [ dockerfile-mode ] -- Dockerfile

(use-package dockerfile-mode
  :ensure t
  :defer t
  :after company
  :init
  (add-to-list 'company-keywords-alist
               '(dockerfile-mode
                 "FROM"
                 "ADD" "COPY"
                 "RUN" "CMD" "ENTRYPOINT"
                 "VOLUME" "ENV" "EXPOSE"  "LABEL" "ARG"
                 "STOPSIGNAL" "USER"  "WORKDIR"
                 "ONBUILD" "HEALTHCHECK" "SHELL"))
  )

;;; [ docker-compose-mode ] -- Major mode for editing docker-compose files.

(use-package docker-compose-mode
  :ensure t
  :defer t)

;;; [ docker-tramp ]

(use-package docker-tramp
  :ensure t
  :init
  (setq docker-tramp-use-names t)
  ;; (setq docker-tramp-docker-options nil)

  (defun docker-tramp-insert-running-container (container)
    "A helper function to insert the running `CONTAINER' name.
For Org-babel header argument :dir /docker:<name>:."
    (interactive (let ((containers-name (mapcar 'cdr (docker-tramp--running-containers)))
                       (containers-id (docker-tramp--running-containers)))
                   ;; `docker-tramp--running-containers' return a list of the form (ID NAME):
                   ;; '(("24dbb476cdd8"  "container_name")
                   ;;   ("bbd4f62e9f1d"  "other_name"))
                   ;; I think completing-read will recognize it as collection,
                   ;; but if you want to use the container names, you need to use:
                   ;; (mapcar 'cdr (docker-tramp--running-containers))
                   (list (completing-read "Docker container name: " containers-name))))
    (insert (format ":dir /docker:%s:" container)))
  (with-eval-after-load "ob-keys"
    (define-key org-babel-map (kbd "M-d") 'docker-tramp-insert-running-container))
  )

;;; [ docker-api ] -- Emacs interface to the Docker API.

(use-package docker-api
  :ensure t
  :defer t)

;;; [ k8s-mode ] -- Kubernetes mode for Kubernetes config files in Emacs.

(use-package k8s-mode
  :ensure t
  :mode (".*/\\.kube/config\\'" . k8s-mode)
  :hook (k8s-mode . yas-minor-mode))

;;; [ kubernetes ] -- Emacs porcelain for Kubernetes. A magit-style interface to the Kubernetes command-line client.

(use-package kubernetes
  :ensure t
  :defer t
  :commands (kubernetes-display-pods kubernetes-display-configmaps))

;;; [ kubernetes-tramp ] -- offers a TRAMP method for Docker containers deployed in a Kubernetes cluster.

(use-package kubernetes-tramp
  :ensure t
  :defer t)


(provide 'init-docker)

;;; init-docker.el ends here
