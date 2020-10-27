;; Disable the startup message.
(setq inhibit-startup-message t)

;; Disable superfluous UI elements.
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Remove padding where the scroll bar was.
(set-fringe-mode 0)

;; Use visual-bell instead of making noise.
(setq visual-bell t)

;; Better font.
(set-face-attribute 'default nil :font "M+ 2m" :height 120)

;; Make emacs' customization system write settings to the
;; (unloaded) custom.el.
(setq custom-file (concat user-emacs-directory "/custom.el"))

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

;; Ivy autocompletion
(use-package ivy
  :config
  (ivy-mode 1))

;; Install all the icons for the modeline display.
(use-package all-the-icons)

;; Add a nicer modeline.
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-major-mode-icon nil))

;; Load some nicer UI colors.
(use-package doom-themes)
(load-theme 'doom-nord t)

;; Keep track of column numbers and show them in the modeline.
(column-number-mode)

;; User colouring for different parantheses and delimiters.
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Make keybindings more discoverable.
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; Load better context in the M-x screen.
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Actually use counsel M-x for the M-x screen. This also
;; uses Ivy in some way. Not sure how these are related.
(use-package counsel
  :bind (("M-x" . counsel-M-x))
  :config
  (setq ivy-initial-inputs-alist nil))
