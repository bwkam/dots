{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.editors.code;
in
{
  options.modules.editors.code.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf cfg.enable {

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        catppuccin.catppuccin-vsc
      ];
    };
  };
}
