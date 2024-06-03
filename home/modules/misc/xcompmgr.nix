{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.misc.xcompmgr;
in {
  options.modules.misc.xcompmgr.enable = lib.mkEnableOption "Enable xcompmgr";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [xcompmgr];

    systemd.user.services.xcompmgr = {
      Unit = {
        Description = "Simple and fast compositing";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Service = {
        Restart = "always";
        ExecStart = "${lib.getExe pkgs.xcompmgr} -c -n -C -F -f";
      };
    };
  };
}
