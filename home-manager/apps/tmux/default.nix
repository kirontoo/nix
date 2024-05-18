{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
      [
        # {
        #   plugin = tmuxPlugins.catppuccin;
        #   extraConfig = '' 
        #   set -g @catppuccin_flavour 'mocha'
        #   set -g @catppuccin_window_tabs_enabled on
        #   set -g @catppuccin_date_time "%H:%M"
        #   set -g @catppuccin_window_status_enable "yes"
        #
        #   # Status line
        #   set -g @catppuccin_window_right_separator "█ "
        #   set -g @catppuccin_window_number_position "right"
        #   set -g @catppuccin_window_middle_separator " | "
        #
        #   set -g @catppuccin_window_default_fill "none"
        #
        #   set -g @catppuccin_window_current_fill "all"
        #
        #   set -g @catppuccin_status_modules_left "directory"
        #   set -g @catppuccin_status_modules_right "application session user host date_time"
        #   set -g @catppuccin_status_left_separator "█"
        #   set -g @catppuccin_status_right_separator "█"
        #
        #   set -g @catppuccin_date_time_text "%H:%M:%S"
        #   '';
        # }
        {
          plugin = tmuxPlugins.yank;
        }
        {
          plugin = tmuxPlugins.sensible;
        }
        {
          plugin = tmuxPlugins.resurrect;
        }
        {
          plugin = tmuxPlugins.prefix-highlight;
        }
      ];
    extraConfig = ''
      unbind-key C-b
      set-option -g prefix C-Space
      bind-key C-Space send-prefix
      bind '"' split-window -p 30 -c "#{pane_current_path}"
      bind | split-window -h -p 40 -c "#{pane_current_path}"
      bind-key -n C-S-Left swap-window -t -1
      bind-key -n C-S-Right swap-window -t +1
      bind-key -n M-S-Left previous-window
      bind-key -n M-S-Right next-window 
      bind-key -r h select-pane -L
      bind-key -r j select-pane -D
      bind-key -r k select-pane -U
      bind-key -r l select-pane -R
      unbind-key :
      bind-key . command-prompt

      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1

      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      set -g status-position bottom
      set -g status-justify left
      set -g status-style "fg=colour15"
      set -g status-left ""
      set -g status-right "#[fg=colour0,bg=colour14] %Y/%m/%d #[fg=colour0,bg=colour13] %I:%M%P "
      set -g status-right-length 50
      set -g status-left-length 20
      setw -g window-status-current-style "fg=colour15 bg=colour1"
      setw -g window-status-current-format " #I#[fg=colour15]:#[fg=colour15]#W#[fg=colour15]#F "
      setw -g window-status-style "fg=colour15"
      setw -g window-status-format " #I#[fg=colour15]:#[fg=colour15]#W#[fg=colour15]#F "
      set -g pane-border-style fg="colour12"
      set -g pane-active-border-style fg="colour12"
    '';
  };
}
