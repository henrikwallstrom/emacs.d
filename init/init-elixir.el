;; elixir programming support.

;;(unless (package-installed-p 'alchemist)
;;  (package-install 'alchemist))

;;(setq alchemist-execute-command "/usr/local/bin/elixir") ;; default: elixir
;;(setq alchemist-mix-command "/usr/local/bin/mix")
;;(setq alchemist-mix-test-task "espec")
;;(setq alchemist-iex-program-name "/usr/local/bin/iex") ;; default: iex

(require 'alchemist)

(add-hook 'alchemist-iex-mode-hook 'company-mode)

;;(defun custom-erlang-mode-hook ()
;;  (define-key erlang-mode-map (kbd "M-,") 'alchemist-goto-jump-back))

;;(add-hook 'erlang-mode-hook 'custom-erlang-mode-hook)

(provide 'init-elixir)
