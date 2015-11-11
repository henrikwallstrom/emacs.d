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
  '(beacon
    smart-mode-line
    rich-minority
    ace-window
    avy
    alchemist
    amd-mode
    atom-one-dark-theme
    color-theme-solarized
    color-theme
    company-tern
    company
    darcula-theme
    dash-functional
    dracula-theme
    editorconfig
    editorconfig-fnmatch
    elixir-mode
    exec-path-from-shell
    f
    flycheck
    grunt
    helm-projectile
    helm
    helm-core
    js2-refactor
    js2-mode
    magit
    git-commit
    magit-popup
    makey
    multiple-cursors
    projectile
    pkg-info
    epl
    s
    seti-theme
    solarized-theme
    tern-auto-complete
    auto-complete
    popup
    tern
    transpose-frame
    vkill
    with-editor
    dash
    async
    yasnippet))

;; Not auto installed
;; zerodark-them

(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-install package)))

(provide 'init-packages)


