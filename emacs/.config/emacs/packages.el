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
  :config
  (setq org-todo-keywords '((sequence "TODO(t)" "PROG(p)" "|" "DONE(d)")
                            (sequence "BACKLOG(b)" "|" "CANCELLED(c@)")))
  :mode ("\\.org\\'" . org-mode))

(use-package ob
  :ensure nil
  :after org
  :config
  (setq org-confirm-babel-evaluate nil
        org-edit-src-content-indentation 0)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (C . t)
     (python . t)
     (scheme . t)
     (shell . t)
     )))

(use-package htmlize
  :after org)

(use-package vterm
  :commands (vterm))

(use-package magit
  :commands (magit-status magit))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package geiser
  :commands (geiser run-geiser)
  :config (setq geiser-mode-start-repl-p t
                geiser-repl-query-on-kill-p nil))

(use-package geiser-guile
  :commands (geiser-guile run-guile))

(use-package sly
  :commands (sly sly-connect)
  :config (setq sly-lisp-implementations
                '((sbcl ("sbcl") :coding-system utf-8-unix))))

(use-package treesit
  :ensure nil
  :defer t
  :init
  (setq treesit-language-source-alist
        '(
          (bash "https://github.com/tree-sitter/tree-sitter-bash")
          (c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (hyprlang "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml")
          (zig "https://github.com/tree-sitter-grammars/tree-sitter-zig")
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

(use-package hyprlang-ts-mode
  :mode ("^.*/hypr/.*\\.conf\\'"))

(use-package json-ts-mode
  :ensure nil
  :config (add-to-list 'major-mode-remap-alist '(js-json-mode . json-ts-mode))
  :mode ("\\.jsonc?\\'"))

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

(use-package zig-ts-mode
  :mode ("\\.zig\\'"))

;;; packages.el ends here
