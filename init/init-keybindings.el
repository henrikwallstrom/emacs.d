;; init-keybindings.el --- Global keybindings
(require 'iflipb)

;; OS common 
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "M-s") 'save-buffer)
;;(global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "M-w") 'kill-buffer)
;;(global-set-key (kbd "M-w") 'delete-window)
;; (global-set-key (kbd "M-§") 'other-frame)
;; (global-set-key (kbd "C-§") 'other-window)
(global-set-key (kbd "M-§") 'other-frame)

(global-set-key (kbd "<C-tab>") 'iflipb-next-buffer)
(global-set-key
 (if (featurep 'xemacs) (kbd "<C-iso-left-tab>") (kbd "<C-S-iso-lefttab>"))
 'iflipb-previous-buffer)

(global-set-key (kbd "M-1") 'zoom-window-zoom)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-4") 'balance-windows)
(global-set-key (kbd "M-9") 'delete-other-windows)

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "M-t") 'helm-mini)
(global-set-key (kbd "M-o") 'sr-open-file)
(global-set-key (kbd "C-x C-o") 'sr-open-file)

;; If you want to be able to M-x without meta
(global-set-key (kbd "C-x C-m") 'helm-M-x)

;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'text-scale-set)


;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Maximize
(global-set-key (kbd "M-RET") 'toggle-frame-maximized)

;; Help
(define-key 'help-command (kbd "C-m") 'discover-my-major)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)


;; Multiple-cursors
(global-set-key (kbd "M-d") 'mc/mark-next-like-this)
(global-set-key (kbd "M-D") 'mc/unmark-next-like-this)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-x M-l") 'magit-log)
(global-set-key (kbd "C-x M-b") 'magit-blame)

;; Replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(global-set-key (kbd "H-o") 'ace-window)

(when (package-installed-p 'dash-at-point)
  (global-set-key (kbd "M-h") 'dash-at-point))

;; Company mode
;;(define-key company-active-map (kbd "TAB") 'company-complete-selection)

;; Debug
(global-set-key [f7] 'previous-error)
(global-set-key [f8] 'next-error)


(provide 'init-keybindings)
