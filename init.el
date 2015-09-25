;;Emacs init file

;;el-get (for easy installation of emacs packages)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;;Load custom theme
(load-theme 'manoj-dark t)

;;For better navigation between windows (makes such a difference!)
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

;;Set default python interpreter to iPython3 (note: plots display in pop-out - can't
;;get inline to work (doesn't show anything))
(setq python-shell-interpreter "C:\\Users\\oxs\\AppData\\Local\\Continuum\\Anaconda3\\python.exe"
      python-shell-interpreter-args
      "-i C:\\Users\\oxs\\AppData\\Local\\Continuum\\Anaconda3\\Scripts\\ipython3-script.py console %*")

;;Display line numbers by default
(global-linum-mode t)

