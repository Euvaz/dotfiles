;;; ui.el -*- lexical-binding: t; -*-
;;; Commentary:
;; UI tweaks.
;;; Variables:

;; Adjust startup behavior
(setq initial-scratch-message nil
      initial-major-mode 'emacs-lisp-mode
      inhibit-startup-screen t)

;; Theme options
(setq modus-themes-italic-constructs t)

;;; Code:

;; Load theme and define font
(load-theme 'modus-vivendi-tinted t)
(set-face-attribute 'default nil :font "Fira Code" :height 160)
(set-face-attribute 'italic nil :font "JetBrains Mono" :height 160)

;; Define frame's background transparency
(set-frame-parameter nil 'alpha-background 97)

;;; ui.el ends here
