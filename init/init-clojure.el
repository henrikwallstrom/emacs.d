(require 'eldoc)
(require 'cider)
(require 'clojure-mode)
(require 'clj-refactor)
(require 'company)

(add-hook 'clojure-mode-hook #'setup-clojure-buffer)
(add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-mode)

;;(cljr-add-keybindings-with-prefix "C-c C-r")

(defun setup-clojure-buffer ()
  (turn-on-eldoc-mode)
  (turn-on-smartparens-mode)
  (clj-refactor-mode 1)
  (setq indent-tabs-mode nil))

(setq cider-repl-use-clojure-font-lock t
      cider-repl-use-pretty-printing t
      cider-repl-wrap-history t
      cider-repl-history-size 3000
      cider-interactive-eval-result-prefix ";; => ")

(provide 'init-clojure)
