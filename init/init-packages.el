;; init-packages.el -- default packages

(require 'cl)
(require 'package)

;; Sources
(let ((sources '(("gnu" . "http://elpa.gnu.org/packages/")
                 ("elpa" . "http://tromey.com/elpa/")
                 ("org" . "http://orgmode.org/elpa/")
                 ("melpa" . "https://melpa.org/packages/"))))
  (dolist (source sources)
    (add-to-list 'package-archives source t))
  (package-initialize))


;;  Refresh the packages descriptions
(when (not package-archive-contents)
  (package-refresh-contents))

;; List from "C-h v package-activated-list"
(defvar my-packages
'(ace-window alchemist amd-mode ag atom-one-dark-theme avy beacon color-theme-solarized color-theme company-tern company darcula-theme dash-at-point dash-functional discover-clj-refactor clj-refactor cider clojure-mode discover-js2-refactor discover dracula-theme editorconfig editorconfig-core editorconfig-fnmatch edn elixir-mode erlang exec-path-from-shell github-browse-file grunt gruvbox-theme helm-projectile helm helm-core hydra inflections js2-refactor magit git-commit magit-popup makey moe-theme multiple-cursors omnisharp csharp-mode flycheck paredit peg powerline prodigy f projectile pkg-info epl queue rainbow-delimiters s seti-theme skewer-mode js2-mode simple-httpd smart-mode-line rich-minority smartparens solarized-theme spinner tern-auto-complete auto-complete popup tern transpose-frame vkill with-editor dash async yasnippet zenburn-theme zerodark-theme zoom-window))

;; Not auto installed
;; zerodark-them

(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-install package)))

(provide 'init-packages)


