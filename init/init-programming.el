;; init-programming.el -- prog-mode configuration

(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'prog-mode-hook 'linum-mode)

(provide 'init-programming)
