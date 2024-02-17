{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.terminal.alacritty;
  colors = builtins.fromTOML (builtins.readFile ./catppuccin-mocha.toml);
in {

  options.modules.terminal.alacritty.enable =
    lib.mkEnableOption "Enable Alacritty";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package =
        (inputs.nixpkgs-unstable.legacyPackages."x86_64-linux".alacritty);
      settings = {
        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#ffffff";
        };
        font = {
          normal = {
            family = "Iosevka";
            style = "Medium";
          };

          bold = {
            family = "Iosevka";
            style = "Bold";
          };

          italic = {
            family = "Iosevka";
            style = "Light Italic";
          };
        };
        keyboard.bindings = [{
          key = 53;
          mods = "Shift";
          mode = "Vi";
          action = "SearchBackward";
        }];
        selection.save_to_clipboard = true;
        shell.program = "${pkgs.fish}/bin/fish";
        window = {
          decorations = "full";
          padding = {
            x = 15;
            y = 15;
          };
        };
      } // colors;
    };
  };
}
