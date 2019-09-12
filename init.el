;;; package --- Summary
;;; Code:
;;; Commentary:

;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

(setenv "PATH" (concat (getenv "PATH") ":/Users/nguyenquockien/.bash_profile"))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)

(require 'lang-go)

(require 'lang-javascript)

(require 'lang-web)

(add-to-list 'load-path (concat user-emacs-directory "vendor"))

(require 'rubocop)
(require 'rubocopfmt)
(require 'lang-ruby)

(provide 'init)
;;; init ends here
