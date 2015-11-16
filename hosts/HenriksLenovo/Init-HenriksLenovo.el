(when (window-system)
  (set-face-attribute 'default nil
                      :family "Consolas" :height 140))

;;TODO: http://aspell.net/win32/
;;(setq-default ispell-program-name "C:/bin/Aspell/bin/aspell.exe")
;;(setq text-mode-hook '(lambda() (flyspell-mode t) ))



(provide 'init-HenriksLenovo)
