(require 'csharp-mode)


(defun my-csharp-mode-hook ()
  (omnisharp-mode)
  (electric-pair-mode 1))

(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)


(provide 'init-csharp)
