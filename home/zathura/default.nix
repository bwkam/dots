{ pkgs, config, lib, ... }: {
  programs.zathura = { enable = true; };

  xdg.configFile."zathura/zathurarc" = {
    text = ''
      include catppuccin-mocha
    '';
  };

  xdg.configFile."zathura/catppuccin-mocha" = { source = ./catppuccin-mocha; };
}
