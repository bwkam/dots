{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.misc.mpd;
in {
  options.modules.misc.mpd.enable = lib.mkEnableOption "mpd";
  config = lib.mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music/emo-rap";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      extraConfig = ''
         bind_to_address "127.0.0.1"
        audio_output {
             type  "pulse"
             name  "pulse audio"
             server "127.0.0.1" # add this line - MPD must connect to the local sound server
         }

        audio_output {
            type                    "fifo"
            name                    "my_fifo"
            path                    "/tmp/mpd.fifo"
            format                  "44100:16:2"
        }

      '';
    };
  };
}
