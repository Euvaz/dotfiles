;;; editor.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Editor tweaks.
;;; Code:

;; Disable backup files
(setq make-backup-files nil)

;; Enable final newlines
(setq require-final-newline t)

;; Define indentation rules
(setq-default indent-tabs-mode nil)

;; Display line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;; editor.el ends here
