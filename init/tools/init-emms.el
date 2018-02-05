;;; init-emms.el --- init for EMMS
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; emms prefix keybinding map
(unless (boundp 'emms-prefix)
  (define-prefix-command 'emms-prefix))
(define-key tools-prefix (kbd "e") 'emms-prefix)

;;; [ EMMS ]

(use-package emms
  :ensure t
  :load (emms-setup)
  :init
  (define-key emms-prefix (kbd "e") 'emms)
  (add-to-list 'display-buffer-alist
               '("^\\*EMMS Playlist\\*" (display-buffer-below-selected)))
  :config
  (emms-all)
  ;; [ players ]
  (emms-default-players)

  ;; [ Playlist ]
  ;; setq `emms-last-played-format-alist'

  (setq emms-source-file-default-directory "~/Music/")

  ;; (setq emms-repeat-playlist nil) ; don't repeat the playlist after the last track.
  
  ;; [ Track ]
  
  ;; [ Score ]
  (emms-score 1)

  ;; [ Encoding ]
  (require 'emms-info-mp3info)
  (setq emms-info-mp3info-coding-system '(utf-8 gbk)
        emms-cache-file-coding-system 'utf-8)

  ;; [ Streams: Radio, Podcasts ]

  ;; Switch to the radio buffer
  (defun my-emms-streams ()
    "Switch to streams buffer, if does not exists, then start emms-streams."
    (interactive)
    (let ((buf (get-buffer emms-stream-buffer-name)))
      (if buf
          (switch-to-buffer buf)
        (emms-streams))))

  ;; [ Key Bindings ]
  (setq emms-info-asynchronously nil)
  (setq emms-playlist-default-major-mode 'emms-mark-mode)

  ;; [ MPD ] -- [M-x emms-player-mpd-connect]
  (require 'emms-player-mpd)

  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd t)
  
  (setq emms-player-mpd-server-name "127.0.0.1"
        emms-player-mpd-server-port "6600")
  (setq emms-player-mpd-music-directory "~/Music/music/")

  ;; (global-set-key (kbd "Fn + <F10>") 'emms-player-mpd-pause)

  (unless (boundp 'emms-mpd-prefix)
    (define-prefix-command 'emms-mpd-prefix))
  (define-key emms-prefix (kbd "m") 'emms-mpd-prefix)

  (define-key emms-mpd-prefix (kbd "m") 'emms-player-mpd-connect)
  (define-key emms-mpd-prefix (kbd "c") 'emms-player-mpd-connect)
  (define-key emms-mpd-prefix (kbd "s") 'emms-player-mpd-start)
  (define-key emms-mpd-prefix (kbd "p") 'emms-player-mpd-play)
  ;; TODO: (emms-player-mpd-get-mpd-state nil #'ignore info)
  (define-key emms-mpd-prefix (kbd "SPC") 'emms-player-mpd-show)
  (define-key emms-mpd-prefix (kbd "P") 'emms-player-mpd-pause)
  (define-key emms-mpd-prefix (kbd "S") 'emms-player-mpd-stop)

  ;; [ mpv ]
  (use-package emms-player-mpv
    :ensure t
    :config
    (add-to-list 'emms-player-list 'emms-player-mpv))

  ;; [ BBT: SBaGen ]
  (define-emms-simple-player sbagen '(file) (emms-player-simple-regexp "sbg") "sbagen")

  ;; [ emms-bilibili ] -- Play Bilibili user favourite videos in EMMS.
  (use-package emms-bilibili
    ;; :ensure t
    :load-path "~/Code/Emacs/emms-bilibili"
    :commands (emms-bilibili)
    :config
    (setq emms-bilibili-mid
          (string-to-number (my/json-read-value my/account-file 'emms-bilibili)))
    (setq emms-bilibili-use-popup t))
  )


(provide 'init-emms)

;;; init-emms.el ends here
