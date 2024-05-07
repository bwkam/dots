{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.misc.pywal;
in
{
  options.modules.misc.pywal.enable = lib.mkEnableOption "enable pywal";

  config = lib.mkIf cfg.enable {

    programs.pywal = {
      enable = true;
    };

    programs.fish.shellInit = ''
      if test -e ~/.cache/wal/colors.fish
          source ~/.cache/wal/colors.fish
      end
    '';
  };
}
