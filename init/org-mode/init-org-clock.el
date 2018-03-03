;;; init-org-clock.el --- init for Org-mode timer and clock.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Timer ]

(require 'org-timer)

(setq org-timer-default-timer 25)       ; Pomodoro time management technique.
(setq org-timer-display 'mode-line)


;;; [ Clock ]

(use-package org-clock
  :ensure-system-package (aplay . "sudo pacman -S --noconfirm alsa-utils"))

(setq org-clock-persist t ; nil, t, 'clock, 'history
      org-clock-persist-query-save t
      org-clock-persist-query-resume t
      org-clock-persist-file (concat user-emacs-directory "org-clock-save.el")
      org-clock-in-resume t    ; resume when clock in.
      org-clock-continuously nil ; don't continue on last clock out.
      org-clock-in-switch-to-state "STARTED"
      org-clock-out-when-done t         ; clock will stop when task marked DONE.
      org-clock-into-drawer t  ; Save clock data and notes in the :LOGBOOK: drawer
      org-clock-out-remove-zero-time-clocks t ; Removes clocked tasks with 0:00 duration
      org-clock-sound (concat user-emacs-directory "resources/audio/Ingress/Speech/speech_hacking.wav")
      ;; 'mode-line, 'frame-title, 'both, nil.
      org-clock-clocked-in-display 'frame-title
      ;; org-clock-mode-line-entry t
      org-clock-mode-line-total 'auto
      ;; org-clock-clocktable-language-setup
      ;; org-clock-leftover-time
      ;; org-clock-task-overrun
      ;; org-clock-task-overrun-text
      ;; org-clock-clocktable-default-properties '(:maxlevel 2 :scope file)
      org-clock-report-include-clocking-task t
      ;; org-agenda-clockreport-mode
      ;; org-agenda-start-with-clockreport-mode t
      org-clock-goto-may-find-recent-task t
      ;; org-clock-total-time-cell-format "*%s*"
      org-clock-idle-time nil             ; t
      ;; org-clock-auto-clock-resolution 'when-no-clock-is-running
      ;; org-clock-resolve-expert t
      org-clock-history-length 20 ; keep a long clocking tasks history for easy re-select history task to clock.
      )


;;; To save the clock history across Emacs sessions, use
(if (file-exists-p org-clock-persist-file)
    ;; (setq org-clock-persist 'history)
    (org-clock-persistence-insinuate)
  (shell-command (concat "touch " org-clock-persist-file)))

;; (add-hook 'org-clock-out-hook 'org-clock-remove-empty-clock-drawer) ; `org-clock-out-remove-zero-time-clocks'

(define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
(define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)


(add-hook 'org-clock-in-hook
          (lambda ()
            (org-clock-play-sound
             (concat user-emacs-directory
                     "resources/audio/Ingress/Speech/speech_hacking.wav"))))
(add-hook 'org-clock-in-prepare-hook
          (lambda ()
            (org-clock-play-sound
             (concat user-emacs-directory
                     "resources/audio/Ingress/SFX/sfx_typing.wav"))))
(add-hook 'org-clock-out-hook
          (lambda ()
            (org-clock-play-sound
             (concat user-emacs-directory
                     "resources/audio/Hacking Game/voice-complete.wav"))))
(add-hook 'org-clock-cancel-hook
          (lambda ()
            (org-clock-play-sound
             (concat user-emacs-directory
                     "resources/audio/Hacking Game/hesfx_untold_tick2.wav"))))


(provide 'init-org-clock)

;;; init-org-clock.el ends here
