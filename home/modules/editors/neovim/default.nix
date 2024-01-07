{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.editors.nvim;
in {
  options.modules.editors.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "nvim/lua".source = ./lua;
      "nvim/init.lua".source = ./init.lua;
    };
    programs.neovim = {
      enable = true;
    };
  };
}
