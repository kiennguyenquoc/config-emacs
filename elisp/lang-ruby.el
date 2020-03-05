;;; package --- Summary
;;; Code:
;;; Commentary:

;; (use-package ruby-mode
;;   :mode
;;   (("\\.rb\\'" . ruby-mode)))

(use-package enh-ruby-mode
  :mode
  (("\\.rb\\'" . enh-ruby-mode)))

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(use-package inf-ruby)

(use-package robe
  :config
  (push 'company-robe company-backends))

(use-package rinari
  :ensure t)
(use-package flymake-ruby
  :ensure t)
(use-package ruby-end
  :ensure t)

(add-hook 'enh-ruby-mode-hook 'rubocopfmt-mode)
(add-hook 'enh-ruby-mode-hook 'rubocop-mode)
(add-hook 'enh-ruby-mode-hook 'flymake-ruby-load)
(add-hook 'enh-ruby-mode-hook 'robe-mode)


(add-hook 'enh-ruby-mode-hook
          (lambda () (hs-minor-mode)))

(unless (package-installed-p 'inf-ruby)
  (package-install 'inf-ruby))

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
    `(enh-ruby-mode
      ,(rx (or "module" "do" "if" "while" "def" "class" "begin" "{" "[" "unless" "function")) ; Block start
      ,(rx (or "}" "]" "end"))                       ; Block end
      ,(rx (or "#" "=begin"))                        ; Comment start
      ruby-forward-sexp nil)))

(setq ruby-deep-indent-paren nil)


(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(provide 'lang-ruby)
;;; lang-ruby ends here
