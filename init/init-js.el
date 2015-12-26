(require 'js2-mode)
(require 'js2-refactor)
(require 'amd-mode)
(require 'tern)
(require 'company-tern)
(require 'grunt)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook (lambda ()
                           (setq mode-name "JS2")
                           (js2-refactor-mode 1)
                           (amd-mode)
                           (tern-mode)
                           (ggtags-mode)
                           (setq-local compile-command "grunt")
                           (setq tab-width 4
                                 indent-tabs-mode t)))

(provide 'init-js)

