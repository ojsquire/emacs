;; emacs config


;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Where to look for packages (in order of precedence)
(setq package-archives
      '(("GNU ELPA"     . "http://elpa.gnu.org/packages/")
        ("MELPA Stable" . "http://stable.melpa.org/packages/")
        ("MELPA"        . "http://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 1)))

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
        helm
        jedi
        magit
        highlight-indent-guides
        moe-theme
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


;; LINE LENGTH & NUMBERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     Display both line and column number by default
(setq column-number-mode t)

;; Turn on line numbers on left side by default
;; BUT not for pdfs! (screws up pdf-tools)
(global-linum-mode t)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

;; Highlight beyond 90 characters on a line
(require 'whitespace)
(setq whitespace-line-column 90)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode 1)


;; INDENTATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Replaces tabs with spaces
(setq-default indent-tabs-mode nil)

;; Use highlight-indent mode automatically
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;; COPY AND PASTE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make syst copy work w/ Emacs paste & Emacs copy work with sys paste
;; and also allow emacs -> tmux copy/paste
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; Turn off electric indent mode by default as causes issues when
;; pasting e.g. from the browser
(electric-indent-mode 0)


;; THEMES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use moe-theme on start-up
(require 'moe-theme)
(moe-dark)


;; CONNECTING TO EXTERNAL MACHINES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
     ;; French  
     "mot de passe" "Mot de passe"  
     ;; Booking 2FA  
     "2FA Token" "2FA token")  
   t)  
  ".*:\0? *"))  
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))


;; MAC OS SPECIFIC SETTINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ensure that env variables inside emacs are same as on shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Turns of internationalization on Mac OS X 10.0 and higher
;; (on by default)
(set-keyboard-coding-system nil)


;; BACKUPS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Save all backup files in dedicated directory to prevent 
;; having to delete them from all over the place and accidently saving them to
;; git. Create all saves as copies rather than linked (could create confusion)
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (highlight-indent-guides use-package solarized-theme pdf-tools moe-theme magit jedi htmlize hive helm-spotify-plus exec-path-from-shell elpygen elpy afternoon-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
