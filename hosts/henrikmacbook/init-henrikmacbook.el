;;(setq my-projectsdir "~/Projects")
;;(let (default-directory my-projectsdir))

(set-default-font "Monaco 16")
;;(set-face-attribute 'default nil :family "Inconsolata" :height 180)

(defvar alchemist-path  "~/Project/github/alchemist.el/")
(defvar emacs-elixir-path "~/Project/github/emacs-elixir/")

(defvar elixir-path "~/Project/github/elixir/")
(defvar otp-path "~/Project/github/otp/")

(defvar omnisharp-server-executable-path "~/Project/github/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe") 

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))


(provide 'init-henrikmacbook)
