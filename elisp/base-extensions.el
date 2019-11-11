;;; package --- Summary
;;; Code:
;;; Commentary:


;; Bootstrap `use-package`

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(require 'use-package)

(use-package all-the-icons
  :ensure t)

;; avy-mode
(use-package avy
  :ensure t
  :bind
  ("M-g g" . avy-goto-line)
  ;; ("c-s-o" . avy-goto-word-opr-subword-1)
  ("M-g s" . avy-goto-char-timer)
  :config
  (avy-setup-default) ;; can use c-' after trigger isearch
  )

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure)

(use-package emmet-mode
  :init (add-to-list 'load-path "~/emacs.d/emmet-mode")
  )

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  )

(use-package company-tabnine
  :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  (setq company-show-numbers t)
  (setq company-idle-delay 0)
  )


(use-package company-restclient
  :config
  (add-to-list 'company-backends 'company-restclient))

(use-package highlight-symbol)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode))

;; (use-package counsel
;;   :bind
;;   ("M-x" . counsel-M-x)
;;   ("C-x C-m" . counsel-M-x)
;;   ("C-x C-f" . counsel-find-file)
;;   ("C-x c k" . counsel-yank-pop))

(use-package smex)
;; Smex - enhance M-x key
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; flx-ido-mode
(use-package flx-ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(flx-ido-mode 1)

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)

  (projectile-mode))
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package ivy
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :config
  (setq magit-diff-refine-hunk t)
  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


(use-package org
  :config
  (setq org-todo-keywords
	'((sequence "BACKLOG" "IN-PROGRESS" "REVIEWING" "DONE" "PENDING" "CANCELLED")))
  (setq org-tag-alist '(("@skylab-innogram" . ?s) ("@personal" . ?p)))
  (setq org-priority-faces '((?A . (:foreground "Red" :weight bold))
                           (?B . (:foreground "Yellow"))
                           (?C . (:foreground "LightSteelBlue"))))
  (setq org-log-done t)
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c b" . org-iswitchb))

(use-package page-break-lines)

(use-package restclient)

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens)

;; (use-package undo-tree
;;   :config
;;   ;; Remember undo history
;;   (global-undo-tree-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("C-S-i" . windmove-up)
  ("C-S-k" . windmove-down)
  ("C-S-j" . windmove-left)
  ("C-S-l" . windmove-right))

(use-package wgrep)

(use-package yasnippet
  :config
  (yas-global-mode 1))

;; Ido-imenu
(use-package idomenu
  :config
  (setq imenu-auto-rescan 1)
  (global-set-key (kbd "M-i") 'idomenu))

(provide 'base-extensions)
;;; base-extensions ends here
