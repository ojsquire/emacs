;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Customized variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-auto-character-face-perc 50)
 '(highlight-indent-guides-auto-even-face-perc 50)
 '(highlight-indent-guides-auto-odd-face-perc 50)
 '(highlight-indent-guides-method (quote character))
 '(package-selected-packages (quote (highlight-indent-guides moe-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Use moe-theme on start-up
(require 'moe-theme)
(moe-dark)

;; Use Python 3 by default in shell
(setq python-shell-interpreter "/usr/bin/python3")

;; Use highlight-indent mode automatically
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
