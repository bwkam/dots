{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.tmux;
in {
  options.modules.dev.tmux.enable = lib.mkEnableOption "enable tmux";
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        # remap prefix from 'C-b' to 'C-a'
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes using n and v
        bind n split-window -h
        bind v split-window -v
        unbind '"'
        unbind %

        # hjkl pane movement
        bind -n M-l select-pane -L
        bind -n M-h select-pane -R
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D

        # H/L window movement
        bind -n M-H previous-window
        bind -n M-L next-window

        # enable mouse
        set -g mouse on

        # don't name windows automatically
        set-option -g allow-rename off

        # no delay when esc pls
        set -sg escape-time 0

        # vi mode (hot)
        setw -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
        bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel

        # customize the bar
        set-option -g status-style bg=#262626
        set-option -g status-justify absolute-centre
        set-option -g status-right "%H:%M"
        set-option -g status-left "#{=21:pane_title}"
        set-option -g window-status-style bg=#0C0C0C
        set-option -g window-status-current-style bg=#A5A5A5,fg=black
      '';
    };
  };
}
