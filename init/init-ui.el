;; init-ui.el --- UI optimizations and tweaks.

;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode -1)

;; enable y/n answers
(defalias 'yes-or-no-p 'y-or-n-p)

;; turn off the blinking cursor
(blink-cursor-mode -1)

(setq-default cursor-type 'bar)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(scroll-bar-mode -1)


;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(require 'powerline)

;; Theme (http://emacsthemes.com/themes/)

;;(require 'zerodark-theme)
;;(load-theme 'zerodark)
;;(load-theme 'seti t)
;;(when (display-graphic-p)
(require 'moe-theme)
(load-theme 'moe-dark t)
;;(moe-theme-set-color 'w/b)
(moe-theme-set-color 'yellow)
(powerline-moe-theme)
(setq moe-theme-highlight-buffer-id t)
(set-face-foreground 'font-lock-doc-face "DarkGray")

;; highlight the current line
(global-hl-line-mode +1)
;;)
;;(load-theme 'zenburn t)
;;(load-theme 'gruvbox t)
;;(load-theme 'atom-one-dark t)
;;(load-theme 'dracula t)
;;(load-theme 'solarized t)

(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
;; delegate theming to the currently active theme
(add-hook 'after-init-hook #'sml/setup)
(when (display-graphic-p)
  (setq sml/theme nil))

;; show the cursor when moving after big movements in the window
(require 'beacon)
(beacon-mode +1)

;; change color of matching paren to make it easir to se cursor
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#f66")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;;(setq sp-highlight-pair-overlay nil)
;;(setq sp-highlight-wrap-overlay nil)
;;(setq sp-highlight-wrap-tag-overlay nil)


(provide 'init-ui)
