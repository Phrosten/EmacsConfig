
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(setq default-directory "~/")

(setq gc-cons-threshold 20000000)

(setq visible-bell t)

(setq-default dired-listing-switches "-alh")

(defvar package-list '())

(require 'package)
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list (append package-list '(
    ox-gfm
)))

(setq package-list (append package-list '(
    elpy
    flycheck
    py-autopep8
)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      package-list)

(eval-after-load "org"
  '(require 'ox-gfm nil t))

(elpy-enable)
(setq elpy-rpc-python-command "python3")

(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq org-babel-python-command "python3")
(org-babel-do-load-languages
      'org-babel-load-languages
      '((python . t)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-linum-mode 1)

(setq-default word-wrap t)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq require-final-newline t)

(setq standard-indent 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(delete-selection-mode t)

(global-font-lock-mode t)
(setq org-src-fontify-natively t)    ; Enable in org mode

(show-paren-mode t)
(setq show-paren-delay 0.0)

(transient-mark-mode t)

(add-hook 'before-save-hook
    (lambda ()
        (when buffer-file-name
            (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                    (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                    (make-directory dir t))))))

(setq vc-follow-symlinks t)

(global-auto-revert-mode t)
