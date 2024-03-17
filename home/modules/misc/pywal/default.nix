{ pkgs, lib, config, ... }:

let cfg = config.modules.misc.pywal;

in {
  options.modules.misc.pywal.enable = lib.mkEnableOption "enable pywal";

  config = lib.mkIf cfg.enable { programs.pywal = { enable = true; }; };

}
