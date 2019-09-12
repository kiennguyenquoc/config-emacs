;;; package --- Summary
;;; Code:
;;; Commentary:

(use-package ruby-mode
  :mode
  (("\\.rb\\'" . ruby-mode)))

(use-package inf-ruby)
(use-package robe
  :config
  (push 'company-robe company-backends))

(use-package rinari)
(use-package flymake-ruby)
(use-package ruby-end)

(add-hook 'ruby-mode-hook 'rubocopfmt-mode)
(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook 'robe-mode)


(add-hook 'ruby-mode-hook
          (lambda () (hs-minor-mode)))

(unless (package-installed-p 'inf-ruby)
  (package-install 'inf-ruby))

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
    `(ruby-mode
      ,(rx (or "module" "do" "if" "while" "def" "class" "begin" "{" "[" "unless" "function")) ; Block start
      ,(rx (or "}" "]" "end"))                       ; Block end
      ,(rx (or "#" "=begin"))                        ; Comment start
      ruby-forward-sexp nil)))

(setq ruby-deep-indent-paren nil)


(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(provide 'lang-ruby)
;;; lang-ruby ends here
