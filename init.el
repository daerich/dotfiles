;; Load with (load "path") in ~/.emacs
;; Clean interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-hook 'c-mode-common-hook (lambda () (setq c-basic-offset 4)))
;; Customization
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(let ((default-directory "~/.emacs.d/packs"))
(normal-top-level-add-subdirs-to-load-path))
(load-theme 'dracula t)
(require 'evil)
(evil-mode 1)
