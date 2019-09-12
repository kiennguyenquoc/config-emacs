;;; package --- Summary
;;; Code:
;;; Commentary:
;; Add your custom functions here

;; (defun something
;;    (do-something))

(defun open-local-psql-shell ()
  "Quick open a psql shell connecting to local DB server."
  (interactive)
  (setq sql-user "postgres")
  (setq sql-port 5432)
  (setq sql-host "localhost")
  (setq sql-database "postgres")
  (sql-postgres "psql-local")
  )

(defun open-dlc-mysql-shell ()
  "Quick open a mysql shell connecting to dlc DB server."
  (interactive)
  (setq sql-user "admin")
  (setq sql-password "skylab")
  (setq sql-host "172.17.30.212")
  (setq sql-database "pm_db_dev")
  (sql-mysql "mysql-dlc")
  )

(defun open-local-mysql-shell ()
  "Quick open a mysql shell connecting to local DB server."
  (interactive)
  (setq sql-user "root")
  (setq sql-password "pwd")
  (setq sql-host "localhost")
  (setq sql-database "mysql")
  (sql-mysql "mysql-local")
  )

(defun create-or-switch-to-shell(name)
  (if (get-buffer name)
      (switch-to-buffer name)
    (shell name))
  )

(defun open-local-shell ()
  "Open a shell with name 'local-shell'."
  (interactive)
  (create-or-switch-to-shell "local-shell")
  )
(global-set-key (kbd "C-c s l") 'open-local-shell)

(defun open-server-shell ()
  "Open a shell with name 'local-shell'."
  (interactive)
  (create-or-switch-to-shell "server-shell")
  )
(global-set-key (kbd "C-c s s") 'open-server-shell)

;; Show current file-path in minibuffer and copy it to kill ring (clip-board)
(defun copy-full-path-to-kill-ring ()
  "Copy buffer's full path to kill ring."
  (interactive)
  (let ((buffer-path dired-directory))
    (when buffer-file-name
      (setq buffer-path buffer-file-name))
    (when buffer-path
      (message (concat "Copied full-path to clipboard: " buffer-path))
      (kill-new (file-truename buffer-path)))))

(global-set-key [M-f1] 'copy-full-path-to-kill-ring) ; Or any other key you want

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH env var to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(provide 'base-functions)
;;; base-functions ends here
