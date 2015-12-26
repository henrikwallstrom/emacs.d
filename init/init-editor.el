;; enhance core editing experience

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;; but use settings from .editorconfig if avvailable
(require 'editorconfig)
(editorconfig-mode 1)

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; highlight the current line
(global-hl-line-mode +1)

;; http://www.emacswiki.org/emacs/TrampMode
(require 'tramp)
(setq tramp-default-method "ssh")

;; helm
(require 'helm-config)
(require 'helm-projectile)

(helm-mode 1)

;; projectile
(require 'projectile)
(projectile-global-mode)

(helm-projectile-on)
(setq projectile-enable-caching t)

;; multiple cursors
(require 'multiple-cursors)

;; Paren mode and electric-pair mode
(require 'smartparens-config)
(show-paren-mode t)
;;(electric-pair-mode t)
;;(electric-indent-mode t)

;; Show keystrokes in progress quicker
(setq echo-keystrokes 0.1)

;; Change the behavior of M-f and co to properly handle camelCase
(global-subword-mode t)
;; Do not override `transpose-words', it should not transpose subwords
(define-key subword-mode-map [remap transpose-words] nil)

;; CUA mode (ctr-c ctrl-v support)
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; misc
(require 'transpose-frame)


(provide 'init-editor)
