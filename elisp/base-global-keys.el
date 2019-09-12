;;; package --- Summary
;;; Code:
;;; Commentary:

;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))
(setq ns-function-modifier 'control)

(global-set-key (kbd "M-*") 'pop-tag-mark)

;; (global-set-key (kbd "M-.") 'my-find-tag)

(global-set-key [f8] 'neotree-toggle)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c d") 'hs-show-block)


(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(add-hook 'ruby-mode-hook
          (lambda () (highlight-symbol-mode)))
(add-hook 'js-mode-hook
          (lambda () (highlight-symbol-mode)))
(add-hook 'go-mode-hook
          (lambda () (highlight-symbol-mode)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell      . t)
   (perl       . t)
   (python     . t)
   (sql        . t)
   (ruby       . t)))

(provide 'base-global-keys)
;;; base-global-keys ends here
