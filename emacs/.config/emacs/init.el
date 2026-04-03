;;; init.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Opinionated Emacs config.
;;; Code:

;; Startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s seconds with %d garbage collections."
                     (emacs-init-time "%.2f")
                     gcs-done)))

;; Load files
(load (concat user-emacs-directory "editor.el"))
(load (concat user-emacs-directory "packages.el"))
(load (concat user-emacs-directory "ui.el"))

;; Utilize separate custom-set-variables file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;;; init.el ends here
