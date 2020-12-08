;; Disable the startup message.
(setq inhibit-startup-message t)

;; Disable superfluous UI elements.
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Enable mouse in the terminal
(xterm-mouse-mode 1)

;; Remove padding where the scroll bar was.
(set-fringe-mode 0)

;; Use visual-bell instead of making noise.
(setq visual-bell t)

;; By default, Emacs creates a "backup" file when saving a buffer with the
;; contents of the buffer before saving. (Those are the files ending with a
;; `~` character.) I don't have a usecase for this, so disable this feature.
(setq make-backup-files nil)

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

;; Allow increasing and decreasing the font size with standard
;; shortcuts.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Ivy autocompletion
(use-package ivy
  :bind
  ;; By default, TAB autocompletes, but also functions as RET when
  ;; there is only a single result left. Don't do that, it's really
  ;; annoying to switch what keys do depending on context.
  (:map ivy-minibuffer-map ("TAB" . ivy-partial))

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

;; Better help screens
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Actually use counsel M-x for the M-x screen. This also
;; uses Ivy in some way. Not sure how these are related.
(use-package counsel
  :bind (("M-x" . counsel-M-x))
  ;; By default C-x C-b displays a list of open buffers.
  ;; Alias it to `counsel-switch-buffer` to avoid mistyping
  ;; it.
  :bind (("C-x C-b" . counsel-switch-buffer))
  :config
  (setq ivy-initial-inputs-alist nil))

;; Use the `undo-fu` undo system instead of `undo-tree` which is what
;; evil uses by default. `undo-tree` was quite buggy and didn't work
;; great for me. Let's try this.
(use-package undo-fu)

;; Persistent undo support for `undo-fu`. This should hopefully make
;; undo / redo more like Vim's persistent undo which I'm missing a lot.
(use-package undo-fu-session
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))

(global-undo-fu-session-mode)

;; Vim keybindings to maintain sanity.
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  ;; Use Ctrl-u and Ctrl-d to scroll the buffer.
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-d-scroll t)

  ;; Disable C-i in evil. In the terminal, this is indistinguisable
  ;; from TAB meaning that it conflicts with TAB in org mode.
  (setq evil-want-C-i-jump nil)

  ;; Get redo to work with Evil.
  (setq evil-undo-system 'undo-fu)

  :config
  (evil-mode 1)

  (define-key evil-motion-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-l") #'evil-window-right)

  ;; :q should kill the current buffer rather than quitting emacs entirely
  (evil-ex-define-cmd "q" 'evil-window-delete)
  ;; Need to type out :quit to close emacs
  (evil-ex-define-cmd "quit" 'evil-quit)

  ;; Equivalent to `nnoremap j gj` and `nnoremap k gk`.
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal))

;; Enable better evil integrations with other modes.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Project management and stuff
(use-package projectile
  :init
  ;; Launch dired for the project root in the dired-single buffer.
  (defun duijf-projectile-dired ()
    (interactive)
    (dired-single-magic-buffer (projectile-acquire-root)))

  (setq projectile-switch-project-action 'duijf-projectile-dired)
  (setq projectile-project-search-path '("~/repos/duijf" "~/repos/nixos" "~"))

  ;; Overwrite projectile-dired with duijf-projectile-dired.
  :bind (:map projectile-command-map ("D" . duijf-projectile-dired))

  :bind-keymap
  ("C-c p" . projectile-command-map)

  :custom
  ((projectile-completion-system 'ivy))

  :config
  (projectile-mode)
  (setq projectile-indexing-method 'alien))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package evil-magit
  :after magit)

(use-package org
  :bind
  (:map org-mode-map ("C-c o l" . org-toggle-link-display))

  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files (directory-files "~/todo" t ".org$"))

  (setq org-tag-alist
	'((:startgroup)
	  (:endgroup)
	  ("work" . ?w)
	  ("personal" . ?p)
	  ("comms" . ?c)
	  ("home" . ?h))))

(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/notes"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package evil-org
  :after org-mode
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(define-key evil-normal-state-map (kbd "C-a \\") 'split-window-right)

;; Thanks to https://unix.stackexchange.com/a/152151
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* buffer after the mode has been set and there
;; are other buffers besides *scratch*.
(defun remove-scratch-buffer ()
  (if (and
        (get-buffer "*scratch*")
        (< 1 (length (buffer-list))))
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; Dired tweaks

;; `dired-single` ensures that dired does not open a ton of buffers
;; when you navigate parent/ child folders.
(use-package dired-single
  ;; Remap the dired navigation functions to the `dired-single` variants.
  :hook (dired-mode . (lambda ()
		      (define-key dired-mode-map [remap dired-find-file]
			'dired-single-buffer)
		      (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
			'dired-single-buffer-mouse)
		      (define-key dired-mode-map [remap dired-up-directory]
			'dired-single-up-directory))))

(use-package dired
  :ensure nil
  ;; Hide details like modification time and permissions by default.
  :hook (dired-mode . dired-hide-details-mode)
  :commands (dired dired-jump)
  ;; `dired-jump` opens the directory of the current file in a dired buffer.
  :bind (("C-x C-d" . (lambda ()
			(interactive)
			(dired-single-magic-buffer default-directory))))
  ;; Flags for `ls`. Here's what the short flags do:
  ;;   `-a` - Show hidden files and folders
  ;;   `-h` - Human readable file sizes (1M instead of number of bytes)
  ;;   `-g` - Do not print file owner.
  ;;   `-o` - Do not print file group.
  :custom ((dired-listing-switches "-ahgo --group-directories-first")))

(use-package dired-hide-dotfiles
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))
