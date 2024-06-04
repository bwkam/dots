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

        # enable mouse
                set -g mouse on

        # don't name windows automatically
                set-option -g allow-rename off
      '';
    };
  };
}
