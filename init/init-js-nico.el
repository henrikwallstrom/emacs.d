(require 'js2-mode)
(require 'js2-refactor)
(require 'projectile)
(require 'amd-mode)
(require 'tern)
;; (require 'widgetjs-mode)
(require 'company-tern)
;; (require 'ws-butler)
(require 'flycheck)
;; (require 'ggtags)
(require 'grunt)

(projectile-mode 1)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook (lambda ()
                           (setq mode-name "JS2")
                           (js2-refactor-mode 1)
                           (amd-mode)
                           ;; (widgetjs-mode)
                           (tern-mode)
                           (flycheck-mode)
                           ;; (ws-butler-mode)
                           ;; (ggtags-mode)
                           (setq-local compile-command "grunt")
                           (setq tab-width 4
                                 indent-tabs-mode t)))

(define-key tern-mode-keymap (kbd "C-c C-r") nil)
;;(define-key tern-mode-keymap (kbd "M-.") nil)
;;(define-key tern-mode-keymap (kbd "M-,") nil)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js-mode-map (kbd "M-.") nil)
(define-key js-mode-map (kbd "C-c C-j") nil)
(define-key amd-mode-map (kbd "C-c C-a") #'amd-initialize-makey-group)

;; (add-to-list 'semantic-symref-filepattern-alist '(js2-mode "*.js"))

(defun kill-tern-process ()
  (interactive)
  (delete-process "Tern"))

(add-to-list 'company-backends 'company-tern)

;; paredit-like commands
(defalias 'js2r-raise #'js2r-unwrap)
(define-key js2-mode-map (kbd "<C-right>") #'js2r-forward-slurp)
(define-key js2-mode-map (kbd "<C-left>") #'js2r-forward-barf)
(define-key js2-mode-map (kbd "M-r") #'js2r-raise)
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)
(define-key js2-mode-map (kbd "M-S") #'js-smart-split)

(defun js-smart-split ()
  (interactive)
  (let ((node (js2-node-at-point)))
    (cond ((js2-string-node-p node) (js2r-split-string))
          (t (js2r-split-var-declaration)))))

(defun mdn-search (searchString)
  (interactive (list (read-string "Search: " (current-thing))))
  (browse-url (format "https://developer.mozilla.org/en-US/search?q=%s&topic=js" searchString)))

(define-key js2-mode-map (kbd "C-c m") #'mdn-search)

(defun js2-show-node-at-point ()
  (interactive)
  (let* ((buf (get-buffer-create "*js2-node-at-point*"))
         (node (js2-node-at-point))
         (node-contents (buffer-substring (js2-node-abs-pos node) (js2-node-abs-end node))))
    (with-current-buffer
        (set-buffer buf)
      (delete-region (point-min) (point-max))
      (insert node-contents))))

(defun js2-show-node-parent-at-point ()
  (interactive)
  (let* ((buf (get-buffer-create "*js2-node-at-point*"))
         (node (js2-node-parent (js2-node-at-point)))
         (node-contents (buffer-substring (js2-node-abs-pos node) (js2-node-abs-end node))))
    (with-current-buffer
        (set-buffer buf)
      (delete-region (point-min) (point-max))
      (insert node-contents))))

;; quite useful for debugging
(define-key js2-refactor-mode-map (kbd "C-c C-r p") #'js2-show-node-at-point)

;; modified version of js2-proper-indentation that works with ftgp rules
(defun js2-proper-indentation (parse-status)
  "Return the proper indentation for the current line."
  (save-excursion
    (back-to-indentation)
    (let* ((ctrl-stmt-indent (js2-ctrl-statement-indentation))
           (at-closing-bracket (looking-at "[]})]"))
           (same-indent-p (or at-closing-bracket
                              (looking-at "\\<case\\>[^:]")
                              (and (looking-at "\\<default:")
                                   (save-excursion
                                     (js2-backward-sws)
                                     (not (memq (char-before) '(?, ?{)))))))
           (continued-expr-p (js2-continued-expression-p))
           (declaration-indent (and js2-pretty-multiline-declarations
                                    (js2-multiline-decl-indentation)))
           (bracket (nth 1 parse-status))
           beg indent)
      (cond
       ;; indent array comprehension continuation lines specially
       ((and bracket
             (>= js2-language-version 170)
             (not (js2-same-line bracket))
             (setq beg (js2-indent-in-array-comp parse-status))
             (>= (point) (save-excursion
                           (goto-char beg)
                           (point-at-bol)))) ; at or after first loop?
        (js2-array-comp-indentation parse-status beg))

       (ctrl-stmt-indent)

       ((and declaration-indent continued-expr-p)
        (+ declaration-indent js2-basic-offset))

       (declaration-indent)

       (bracket
        (goto-char bracket)
        (cond
         ((looking-at "[({[][ \t]*\\(/[/*]\\|$\\)")
          (when (save-excursion (skip-chars-backward " \t)")
                                (looking-at ")"))
            (backward-list))
          (back-to-indentation)
          (and (eq js2-pretty-multiline-declarations 'all)
               (looking-at js2-declaration-keyword-re)
               (goto-char (1+ (match-end 0))))
          (setq indent
                (cond (same-indent-p
                       (current-column))
                      (continued-expr-p
                       (+ (current-column) (* 2 js2-basic-offset)))
                      (t
                       (+ (current-column) js2-basic-offset))))
          (if (and js2-indent-switch-body
                   (not at-closing-bracket)
                   (looking-at "\\_<switch\\_>"))
              (+ indent js2-basic-offset)
            indent))
         (t
          ;; (unless same-indent-p
          ;;   (forward-char)
          ;;   (skip-chars-forward " \t"))
          ;; (current-column)

          ;; MODIFIED VERSION
          (if same-indent-p
              (progn
                (if at-closing-bracket
                    (back-to-indentation))
                (current-column))
            (progn
              (back-to-indentation)
              (+ (current-column) js2-basic-offset))))))

       (continued-expr-p js2-basic-offset)

       (t 0)))))

(defun js--proper-indentation (parse-status)
  "Return the proper indentation for the current line."
  (save-excursion
    (back-to-indentation)
    (cond ((nth 4 parse-status)    ; inside comment
           (js--get-c-offset 'c (nth 8 parse-status)))
          ((nth 3 parse-status) 0) ; inside string
          ((eq (char-after) ?#) 0)
          ((save-excursion (js--beginning-of-macro)) 4)
          ;; Indent array comprehension continuation lines specially.
          ((let ((bracket (nth 1 parse-status))
                 beg)
             (and bracket
                  (not (js--same-line bracket))
                  (setq beg (js--indent-in-array-comp bracket))
                  ;; At or after the first loop?
                  (>= (point) beg)
                  (js--array-comp-indentation bracket beg))))
          ((js--ctrl-statement-indentation))
          ((js--multi-line-declaration-indentation))
          ((nth 1 parse-status)
	   ;; A single closing paren/bracket should be indented at the
	   ;; same level as the opening statement. Same goes for
	   ;; "case" and "default".
           (let ((same-indent-p (looking-at "[]})]"))
                 (switch-keyword-p (looking-at "default\\_>\\|case\\_>[^:]"))
                 (continued-expr-p (js--continued-expression-p)))
             (goto-char (nth 1 parse-status)) ; go to the opening char
             (if (looking-at "[({[]\\s-*\\(/[/*]\\|$\\)")
                 (progn ; nothing following the opening paren/bracket
                   (skip-syntax-backward " ")
                   (when (eq (char-before) ?\)) (backward-list))
                   (back-to-indentation)
                   (let* ((in-switch-p (unless same-indent-p
                                         (looking-at "\\_<switch\\_>")))
                          (same-indent-p (or same-indent-p
                                             (and switch-keyword-p
                                                  in-switch-p)))
                          (indent
                           (cond (same-indent-p
                                  (current-column))
                                 (continued-expr-p
                                  (+ (current-column) (* 2 js-indent-level)
                                     js-expr-indent-offset))
                                 (t
                                  (+ (current-column) js-indent-level
                                     (pcase (char-after (nth 1 parse-status))
                                       (?\( js-paren-indent-offset)
                                       (?\[ js-square-indent-offset)
                                       (?\{ js-curly-indent-offset)))))))
                     (if in-switch-p
                         (+ indent js-switch-indent-offset)
                       indent)))
               ;; If there is something following the opening
               ;; paren/bracket, everything else should be indented at
               ;; the same level.
               ; MODIFIED VERSION
               (if same-indent-p
                   (progn
                     (back-to-indentation)
                     (current-column))
                 (progn
                   (back-to-indentation)
                   (+ (current-column) js2-basic-offset)))
               ; COMMENTED ORIGINAL VERSION
               ;; (unless same-indent-p
               ;;   (forward-char)
               ;;   (skip-chars-forward " \t"))
               ;; (current-column)
               )))

          ((js--continued-expression-p)
           (+ js-indent-level js-expr-indent-offset))
          (t 0))))


(provide 'init-js)


(provide 'init-js2-mode)
