;; init company - modular in-buffer completion framework for Emacs

;; completion with company mode
(require 'company)

(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;;(setq company-tooltip-flip-when-above t)


(provide 'init-company)
