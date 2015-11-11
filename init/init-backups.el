;; setups where and how to do backups

;;(defvar my/backup-directory "~/.tmp/"
;;  "The directory to put autosave and backup files")

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; autosave the undo-tree history
(setq undo-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq undo-tree-auto-save-history t)

;; Never create lock files
(setq create-lockfiles nil)


(provide 'init-backups)
