{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.misc.xdg;
in {
  options.modules.misc.xdg.enable = lib.mkEnableOption "xdg";
  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;
      mime.enable = true;
      userDirs.enable = true;
      userDirs.createDirectories = true;

      # Allow files to be opened with appropriate programs
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };
    };
  };
}
