# use UTF8
set -g utf8
set-window-option -g utf8 on

# make tmux display things in 256 colors
set -g default-terminal "xterm-256color"

# set scrollback history to 10000 (10k)
set -g history-limit 10000

# shorten command delay
set -sg escape-time 1

# set window and pane index to 1 (0 by default)
set-option -g base-index 1
setw -g pane-base-index 1

# bind key to ^A
set-option -g prefix C-a
unbind-key C-b
bind-key a send-prefix

# reload ~/.tmux.conf using PREFIX r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# use PREFIX | to split window horizontally and PREFIX - to split vertically
bind | split-window -c "#{pane_current_path}"
bind - split-window -h -c "#{pane_current_path}"
bind n new-window -c "#{pane_current_path}"

# Make the current window the first window
bind T swap-window -t 1

# map Vi movement keys as pane movement keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# and use C-h and C-l to cycle thru panes
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# resize panes using PREFIX H, J, K, L
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5

# This tmux statusbar config was created by tmuxline.vim
# on Wed, 21 Jan 2015

set -g status-bg "colour7"
set -g message-command-fg "colour7"
set -g status-justify "left"
set -g status-left-length "100"
set -g status "on"
set -g pane-active-border-fg "colour11"
set -g message-bg "colour14"
set -g status-right-length "100"
set -g status-right-attr "none"
set -g message-fg "colour7"
set -g message-command-bg "colour14"
set -g status-attr "none"
set -g status-utf8 "on"
set -g pane-border-fg "colour14"
set -g status-left-attr "none"
setw -g window-status-fg "colour14"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour7"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour11"
setw -g window-status-separator ""
setw -g window-status-bg "colour7"
set -g status-left "#[fg=colour7,bg=colour11,bold] #S #[fg=colour11,bg=colour7,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour14,bg=colour7,nobold,nounderscore,noitalics]#[fg=colour7,bg=colour14] %Y-%m-%d  %H:%M #[fg=colour11,bg=colour14,nobold,nounderscore,noitalics]#[fg=colour7,bg=colour11] #h "
setw -g window-status-format "#[fg=colour14,bg=colour7] #I #[fg=colour14,bg=colour7] #W "
setw -g window-status-current-format "#[fg=colour7,bg=colour14,nobold,nounderscore,noitalics]#[fg=colour7,bg=colour14] #I #[fg=colour7,bg=colour14] #W #[fg=colour14,bg=colour7,nobold,nounderscore,noitalics]"
