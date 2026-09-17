;;; early-init.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Runs before everyting else
;;; Code:

;; Prevent toolbar, menu-bar, and scroll-bar from being drawn
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; Raise GC threshold
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 32 1024 1024))))

;;; early-init.el ends here
