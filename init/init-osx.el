;; init-osx.el --- OSX specific settings.

;; Free option on mac
(setq mac-option-modifier nil
      mac-command-modifier 'meta)

;; OS X Path from shell
(exec-path-from-shell-initialize)

;; It's all in the Meta
(setq ns-function-modifier 'hyper)


(defun swap-meta-and-super ()
  "Swap the mapping of Meta and Super."
  (interactive)
  (if (eq mac-command-modifier 'super)
      (progn
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (message "Command is now bound to META and Option is bound to SUPER."))
    (progn
      (setq mac-command-modifier 'super)
      (setq mac-option-modifier 'meta)
      (message "Command is now bound to SUPER and Option is bound to META."))))

(menu-bar-mode +1)

;; Enable emoji, and stop the UI from freezing when trying to display them.
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(set-default-font "Monaco 16")

(provide 'init-osx)
