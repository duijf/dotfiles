;; Disable the startup message.
(setq inhibit-startup-message t)

;; Disable superfluous UI elements.
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remove padding where the scroll bar was.
(set-fringe-mode 0)

;; Use visual-bell instead of making noise.
(setq visual-bell t)

;; Better font.
(set-face-attribute 'default nil :font "M+ 2m" :height 120)

;; Load a slightly improved theme.
(load-theme 'tango-dark)

;; Load the built-in packaging system.
(require 'package)

;; Configure sources for the packaging system.
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the built-in system.
(package-initialize)

;; Refresh the contents of the package mirrors.
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize and install the `use-package` packaging system.
;; This is a different system from the built-in system.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Load the use-package packaging system. (I'm told we want to
;; to use this because it's better than the built in system).
(require 'use-package)

;; Tell `use-package` to always install packages when we `require`
;; them. This means we never miss a package.
(setq use-package-always-ensure t)

;; Make sure escape quits prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
