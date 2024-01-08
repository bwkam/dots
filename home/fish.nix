{ config, lib, pkgs, ... }:

{

  programs.fish.enable = true;
  home.packages =
    [ pkgs.fishPlugins.done pkgs.fishPlugins.github-copilot-cli-fish ];

  programs.fish.shellAliases = with pkgs; {

    ".." = "cd ..";
    cat = "${bat}/bin/bat";
    ls = "${eza}/bin/eza --group-directories-first --git --icons";
    ytmp3 = "yt-dlp --extract-audio --audio-format mp3";
    nvim = "$HOME/script-nvim.sh";
    
};

  programs.fish.shellInit = ''
    set  	fish_color_normal cdd6f4
    set fish_color_command 89b4fa
    set fish_color_param f2cdcd
    set fish_color_keyword f38ba8
    set fish_color_quote a6e3a1
    set fish_color_redirection f5c2e7
    set fish_color_end fab387
    set fish_color_comment 7f849c
    set fish_color_error f38ba8
    set fish_color_gray 6c7086
    set fish_color_selection --background=313244
    set fish_color_search_match --background=313244
    set fish_color_option a6e3a1
    set fish_color_operator f5c2e7
    set fish_color_escape eba0ac
    set fish_color_autosuggestion 6c7086
    set fish_color_cancel f38ba8
    set fish_color_cwd f9e2af
    set fish_color_user 94e2d5
    set fish_color_host 89b4fa
    set fish_color_host_remote a6e3a1
    set fish_color_status f38ba8
    set fish_pager_color_progress 6c7086
    set fish_pager_color_prefix f5c2e7
    set fish_pager_color_completion cdd6f4
    set fish_pager_color_description 6c7086

  '';
}

