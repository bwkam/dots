{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.misc.ncmp;
in {
  options.modules.misc.ncmp.enable = lib.mkEnableOption "ncmp";
  config = lib.mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
        taglibSupport = true;
      };
      mpdMusicDir = "${config.home.homeDirectory}/Music/emo-rap";
      settings = {
        # Miscelaneous
        ncmpcpp_directory = "${config.home.homeDirectory}/.config/ncmpcpp";
        ignore_leading_the = true;
        external_editor = "nvim";
        message_delay_time = 1;
        follow_now_playing_lyrics = "yes";
        lyrics_fetchers = "musixmatch";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_in_stereo = "yes";
        visualizer_type = "spectrum";
        visualizer_look = "+|";
      };
    };
  };
}
