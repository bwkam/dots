{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs.enable = lib.mkEnableOption "emacs";
  imports = [inputs.nix-doom-emacs.hmModule];

  config = lib.mkIf cfg.enable {
    programs.doom-emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      doomPrivateDir = ./.;
    };
  };
}
