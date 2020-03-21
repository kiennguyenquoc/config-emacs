(use-package go-mode
  :config
  ; Use goimports instead of go-fmt
  (add-hook 'go-mode-hook 'company-mode)
  ;; Call Gofmt before saving
  (add-hook 'go-mode-hook 'setup-go-mode-compile)
  (add-hook 'go-mode-hook #'smartparens-mode)
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(add-hook 'before-save-hook 'gofmt-before-save)

;; Golang
(add-to-list 'exec-path "/Users/nguyenquockien/projects/go")
(setenv "GOPATH" "/Users/nguyenquockien/projects/go")

;; Go-mode
(add-hook 'go-mode-hook
          (lambda ()
            (setq gofmt-command "goimports")
            (add-hook 'before-save-hook 'gofmt-before-save)
            (local-unset-key (kbd "M-."))
            (relative-line-numbers-mode)
            (electric-pair-mode)
            ))
(use-package go-autocomplete)

;; auto-complete-mode
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(defun my-go-mode-hook ()
  "Use goimports instead of go-fmt."
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving.
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)
(setq-default flycheck-disabled-checkers '(go-vet))



(use-package company-go
  :after go-mode
  :config
  (setq tab-width 2)

  :bind (:map go-mode-map
  ; Godef jump key binding
  ("M-." . godef-jump)))

(use-package flymake-go)

(use-package go-eldoc
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(defun setup-go-mode-compile ()
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'lang-go)
