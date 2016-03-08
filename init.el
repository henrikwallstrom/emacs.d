;; cusomize file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;(server-start)

;; Always load newest byte code
(setq load-prefer-newer t)

;; packages
(require 'package)
(package-initialize)

;; dir vars
(defvar host (substring (shell-command-to-string "hostname") 0 -1))
(defvar init-dir "~/.emacs.d/init")
(defvar local-packages-dir "~/.emacs.d/local-packages")
(defvar site-lisp-dir "~/.emacs.d/site-lisp")
(defvar host-dir (concat "~/.emacs.d/hosts/" host))

;; load path
(add-to-list 'load-path init-dir)
(add-to-list 'load-path local-packages-dir)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path host-dir)

(dolist (directory (list init-dir local-packages-dir site-lisp-dir))
  (let ((default-directory directory))
    (normal-top-level-add-subdirs-to-load-path)))

;; init
(require 'init-packages)
(require 'init-editor)
(require 'init-backups)
(require 'init-company)
(require 'init-ui)
(require 'init-programming)
(require 'init-elisp)
(require 'init-clojure)
(require 'init-js)
(require 'init-yasnippet)
;;(require 'init-csharp)

(when (memq window-system '(mac ns))
  (require 'init-osx))

(provide 'init-dash-documentation-browser)

(require 'init-keybindings)

(let ((init-host-feature (intern (concat "init-" host))))
  (require init-host-feature nil 'noerror))
;;(require 'init-private-modules)

(require 'init-elixir)


(defun my-visit-pull-request-url ()
  "Visit the current branch's PR on Github."
  (interactive)
  (browse-url
   (format "https://github.com/%s/pull/new/%s"
           (replace-regexp-in-string
            "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1"
            (magit-get "remote"
                       (magit-get-remote)
                       "url"))
           (cdr (or (magit-get-remote-branch)
                    (user-error "No remote branch"))))))

(eval-after-load 'magit
  '(define-key magit-mode-map "v"
     #'endless/visit-pull-request-url))

(defun magit-create-branch-from-jira-issue ()
  (interactive)
  (let ((branch-name (replace-regexp-in-string "[^a-zA-Z0-9-]+" "_" (s-trim (current-kill 0 t))))
        (start-point (magit-read-branch-or-commit "Create branch starting at")))
    (magit-branch branch-name start-point)
    (magit-checkout branch-name)))

(add-hook 'git-commit-mode-hook (lambda ()
                                  (ignore-errors
                                    (when (string-prefix-p "C:\\Projects\\ftgp\\monitor" (magit-toplevel))
                                      (goto-char (point-min))
                                      (insert (format "%s: " (car (s-slice-at "_" (magit-get-current-branch)))))))))




;;;; Integrated find-file
;; If current working directory is project, use help-projectile
;; Else, use find-file
(defun sr-open-file ()
  "Open file using projectile+Helm or ido"
  (interactive)
  (if (projectile-project-p)
      (helm-projectile)
    (helm-for-files)))


(defun my-format-document ()
(interactive)
  (indent-region (point-min) (point-max)) )

(defun tabify-buffer ()
  (interactive)
  (tabify (point-min) (point-max)))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun space->underscore-region (start end)
  "Replace space by underscore in region."
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward " " nil t) (replace-match "_"))))

(defun underscore->space-region (start end)
  "Replace underscore by space in region."
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward "_" nil t) (replace-match " "))))


(defun my-open-with (arg)
  "Open visited file in default external program.
When in dired mode, open file under the cursor.
With a prefix ARG always prompt for command to use."
  (interactive "P")
  (let* ((current-file-name
          (if (eq major-mode 'dired-mode)
              (dired-get-file-for-visit)
            buffer-file-name))
         (open (pcase system-type
                 (`darwin "open")
                 ((or `gnu `gnu/linux `gnu/kfreebsd) "xdg-open")))
         (program (if (or arg (not open))
                      (read-shell-command "Open current file with: ")
                    open)))
    (start-process "prelude-open-with-process" nil program current-file-name)))

(defun my-kill-other-buffers ()
  "Kill all buffers but the current one.
Doesn't mess with special buffers."
  (interactive)
  (when (y-or-n-p "Are you sure you want to kill all buffers but the current one? ")
    (-each
        (->> (buffer-list)
             (-filter #'buffer-file-name)
             (--remove (eql (current-buffer) it)))
      #'kill-buffer)))
