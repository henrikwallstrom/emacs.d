(when (window-system)
  (set-face-attribute 'default nil
                      :family "Consolas" :height 140))

;;TODO: http://aspell.net/win32/
;;(setq-default ispell-program-name "C:/bin/Aspell/bin/aspell.exe")
;;(setq text-mode-hook '(lambda() (flyspell-mode t) ))

(setenv "HOME" "C:\\Users\\henrik")

(if (eq system-type 'windows-nt)
    (progn
      (setq exec-path (add-to-list 'exec-path "C:\\Program Files\\Git\\bin"))
      (setenv "PATH" (concat "C:\\Program Files\\Git\\bin" (getenv "PATH")))))

(defvar alchemist-path  "c:\\Projects\\github\\alchemist.el")
(defvar emacs-elixir-path "c:\\Projects\\github\\emacs-elixir")

(defvar elixir-path "c:\\Projects\\github\\elixir")
(defvar otp-path "c:\\Project\\github\\otp")



(provide 'init-HenriksLenovo)
