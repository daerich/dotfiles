;; Load with (load "path") in ~/.emacs
;; Clean interface
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Customization
(load-theme 'dracula t)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
