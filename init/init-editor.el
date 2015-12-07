;; enhance core editing experience

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance

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

;; multiple cursors
(require 'multiple-cursors)

;; Paren mode and electric-pair mode
(show-paren-mode t)
(electric-pair-mode t)
(electric-indent-mode t)

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

;; move

(defun magit-create-branch-from-jira-issue ()
  (interactive)
  (let ((branch-name (replace-regexp-in-string "[^a-zA-Z0-9-]+" "_" (s-trim (current-kill 0 t))))
        (start-point (magit-read-branch-or-commit "Create branch starting at")))
    (magit-branch branch-name start-point)
    (magit-checkout branch-name)))

(add-hook 'git-commit-mode-hook (lambda ()
                                  (ignore-errors
                                    (when (string-prefix-p "C:\\Projects\\ftgp\\monitor" (magit-toplevel))
                                      (goto-char (point-min))
                                      (insert (format "%s: " (car (s-slice-at "_" (magit-get-current-branch)))))))))



(provide 'init-editor)
