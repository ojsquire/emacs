;; emacs config

;; Turns of internationalization on Mac OS X 10.0 and higher
;; (on by default)
(set-keyboard-coding-system nil)

;; Where to look for packages (in order of precedence)
(setq package-archives
      '(("GNU ELPA"     . "http://elpa.gnu.org/packages/")
        ("MELPA Stable" . "http://stable.melpa.org/packages/")
        ("MELPA"        . "http://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)))

(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Packages to be installed
(setq package-list
      '(exec-path-from-shell
        async
        auto-complete
        bind-key
        elpy
        helm
        multi
        pdf-tools
        jedi
;;        helm-spotify-plus
;;        python-environment
;;        with-editor
;;        git-commit
;;        popup
;;        magit
;;        magit-popup
;;        multiple-cursors
;;        hive
;;        ensime
        ))

;; Update if not installed
(let (update-flag)
  (dolist (pkg package-list update-flag)
    (unless (package-installed-p pkg)
      (setq update-flag 1)))

  (when update-flag
    (package-refresh-contents)
    (dolist (pkg package-list)
      (unless (package-installed-p pkg)
        (package-install pkg)))))

;; Get pdf-tools. Allows to view PDFs and more
(use-package pdf-tools
  :ensure t
  :config
  (custom-set-variables
    '(pdf-tools-handle-upgrades nil)) ; Use brew upgrade pdf-tools instead.
  (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo"))
(pdf-tools-install)

;; Turn on line numbers on left side by default
;; BUT not for pdfs! (screws up pdf-tools)
(global-linum-mode t)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

;; Convenient key binding for using multiple cursors
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; make syst copy work w/ Emacs paste and Emacs copy work with sys paste
;; and also allow emacs -> tmux copy/paste
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; STANDARDISING LINE LENGTH ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     Display both line and column number by default
(setq column-number-mode t)

;; Highlight beyond 80 characters on a line
(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode 1)

;; Replaces tabs with spaces
(setq-default indent-tabs-mode nil)

;; Prevent file backups from being taken, use version control instead
;; http://www.rpi.edu/dept/acs/rpinfo/common/Computing/
;; Consulting/Software/Emacs/Hints/backup.html
(setq make-backup-files nil)

;; Allow use of windmove on the terminal (cannot use modifiers on arrow
;; keys)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Turn off electric indent mode by default as causes issues when
;; pasting e.g. from the browser
(electric-indent-mode 0)

;; AUTOMATIC SYNTAX CHECKING
;; Always turn on flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Flymake customizations for Python
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "/home/osquire/.emacs.d/pycheckers.sh"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
		'("\\.py\\'" flymake-pyflakes-init)))

;; Press this on line with error to Lint it!
(global-set-key (kbd "C-c l") 'flymake-display-err-menu-for-current-line)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (tango-dark)))
 '(fci-rule-color "#14151E")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (elpygen elpy jedi moe-theme solarized-theme afternoon-theme multi helm auto-complete async exec-path-from-shell use-package)))
 '(pdf-tools-handle-upgrades nil)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tramp-password-prompt-regexp
   "^.*\\(2FA \\(?:[Tt]oken\\)\\|Mot de passe\\|Pass\\(?:phrase\\|wor[dt]\\)\\|mot de passe\\|pass\\(?:phrase\\|wor[dt]\\)\\).*: ? *")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Get Tramp working with 2FA
(setq tramp-default-method "sshx"  
      tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")  
(customize-set-variable  
 'tramp-password-prompt-regexp  
 (concat  
  "^.*"  
  (regexp-opt  
   '("passphrase" "Passphrase"  
     ;; English  
     "password" "Password"  
     ;; Deutsch  
     "passwort" "Passwort"  
     ;; Français  
     "mot de passe" "Mot de passe"  
     ;; Booking 2FA  
     "2FA Token" "2FA token")  
   t)  
  ".*:\0? *"))  
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; Auto-refresh file after changes ?
(add-hook 'pdf-view-mode-hook (lambda () (auto-revert-mode 1)))

;; (load-theme 'moe-dark t)

;; Jedi (python autocompletion) configs
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 

;; set version of python to use in the python shell
;; (setq python-shell-interpreter "/Users/osquire/anaconda/bin/python3")

;; Needed to ensure that env variables inside emacs are same as on shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
