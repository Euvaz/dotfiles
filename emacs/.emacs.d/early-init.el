;;; early-init.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Runs before everyting else
;;; Code:

;; Prevent toolbar, menu-bar, and scroll-bar from being drawn
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;;; early-init.el ends here
