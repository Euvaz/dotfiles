;;; packages.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Package specification.
;;; Code:

;; Initialize package archives
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Bootstrap use-package
(eval-when-compile (require 'use-package))
(setq use-package-verbose t
      use-package-compute-statistics t
      use-package-always-ensure t)

(use-package gcmh
  :config (gcmh-mode 1))

(use-package vertico
  :init (setq enable-recursive-minibuffers t)
  :config (vertico-mode t))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :config
  (setq corfu-cycle t
        corfu-on-exact-match nil
        corfu-preselect 'prompt
        text-mode-ispell-word-completion nil)
  :bind (:map corfu-map
              ("TAB" . #'corfu-next)
              ([tab] . #'corfu-next)
              ("S-TAB" . #'corfu-previous)
              ([backtab] . #'corfu-previous)))

(use-package smartparens
  :hook (prog-mode text-mode))

(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode))

(use-package htmlize
  :after org)

(use-package eat
  :commands (eat))

(use-package magit
  :commands (magit-status magit))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package diff-hl
  :after magit
  :config
  (defvar dotfiles-diff-hl--repos nil)

  (defun dotfiles-diff-hl--maybe-enable ()
    (when (and buffer-file-name (member (magit-toplevel) dotfiles-diff-hl--repos))
      (diff-hl-mode 1)))

  (defun dotfiles-diff-hl--set-buffers (root enable)
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (and buffer-file-name
                   (string-prefix-p root (expand-file-name buffer-file-name))
                   (or enable diff-hl-mode)
                   (equal (magit-toplevel) root))
          (diff-hl-mode (if enable 1 -1))))))

  (defun dotfiles-diff-hl--toggle-repo (root enable)
    (if enable
        (push root dotfiles-diff-hl--repos)
      (setq dotfiles-diff-hl--repos (delete root dotfiles-diff-hl--repos)))
    (run-with-timer 0 nil #'dotfiles-diff-hl--set-buffers root enable))

  (defun dotfiles-diff-hl--enable-for-repo ()
    (let ((root (magit-toplevel)))
      (when (and root (not (member root dotfiles-diff-hl--repos)))
        (dotfiles-diff-hl--toggle-repo root t))))

  (defun dotfiles-diff-hl--maybe-disable-for-repo ()
    (when (derived-mode-p 'magit-mode)
      (let ((root (magit-toplevel)))
        (when (and root
                   (member root dotfiles-diff-hl--repos)
                   (not (remq (current-buffer) (magit-mode-get-buffers))))
          (dotfiles-diff-hl--toggle-repo root nil)))))

  (add-hook 'magit-status-mode-hook #'dotfiles-diff-hl--enable-for-repo)
  (add-hook 'kill-buffer-hook #'dotfiles-diff-hl--maybe-disable-for-repo)
  (add-hook 'after-change-major-mode-hook #'dotfiles-diff-hl--maybe-enable)
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(use-package treesit
  :ensure nil
  :defer t
  :init
  (setq treesit-language-source-alist
        '(
          (bash "https://github.com/tree-sitter/tree-sitter-bash")
          (c "https://github.com/tree-sitter/tree-sitter-c")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (lua "https://github.com/tree-sitter-grammars/tree-sitter-lua")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml")
          )))

(use-package bash-ts-mode
  :ensure nil
  :init (add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode))
  :mode ("\\.sh\\'"))

(use-package c-ts-mode
  :ensure nil
  :init (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  :mode ("\\.c\\'"))

(use-package c++-ts-mode
  :ensure nil
  :init (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  :mode ("\\.cpp\\'"))

(use-package cmake-ts-mode
  :ensure nil
  :mode ("\\.cmake\\'"))

(use-package css-ts-mode
  :ensure nil
  :init (add-to-list 'major-mode-remap-alist '(css-mode . css-ts-mode))
  :mode ("\\.css\\'"))

(use-package go-ts-mode
  :ensure nil
  :mode ("\\.go\\'"))

(use-package go-mod-ts-mode
  :ensure nil
  :mode ("go\\.mod\\'"))

(use-package html-ts-mode
  :ensure nil
  :config (add-to-list 'major-mode-remap-alist '(mhtml-mode . html-ts-mode))
  :mode ("\\.html\\'"))

(use-package json-ts-mode
  :ensure nil
  :config (add-to-list 'major-mode-remap-alist '(js-json-mode . json-ts-mode))
  :mode ("\\.jsonc?\\'"))

(use-package lua-ts-mode
  :ensure nil
  :mode ("\\.lua\\'"))

(use-package python-ts-mode
  :ensure nil
  :config (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  :mode ("\\.py[iw]?\\'"))

(use-package toml-ts-mode
  :ensure nil
  :config (add-to-list 'major-mode-remap-alist '(conf-toml-mode . toml-ts-mode))
  :mode ("\\.toml\\'"))

(use-package yaml-ts-mode
  :ensure nil
  :mode ("\\.ya?ml\\'"))

(use-package markdown-mode
  :mode ("\\.md\\'"))

(use-package rust-mode
  :mode ("\\.rs\\'"))

(use-package zig-mode
  :mode ("\\.zig\\'"))

;;; packages.el ends here
