{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        catppuccin.catppuccin-vsc
      ];
  };
}
