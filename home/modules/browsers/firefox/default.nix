{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.browsers.firefox;
in {
  options.modules.browsers.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      # profiles.myprofile.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   enhanced-github
      #   enhancer-for-youtube
      #   refined-github
      #   stylus
      #   react-devtools
      #   ublock-origin
      # ];

      profiles.myprofile = {
        settings."general.smoothScroll" = true;
        extraConfig = ''
          user_pref("browser.urlbar.autoFill", false);
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("layers.acceleration.force-enabled", true);
          user_pref("gfx.webrender.all", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';
      };
    };

    #home.file.".mozilla/firefox/myprofile/chrome" = {
    #source = ./chrome;
    # recursive = true;
    #};
  };
}
