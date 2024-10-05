{
  config,
  lib,
  ...
}: let
  cfg = config.modules.terminal.kitty;
in {
  options.modules.terminal.kitty.enable = lib.mkEnableOption "Enable kitty terminal";

  config = lib.mkIf cfg.enable {
    # Enable the kitty terminal
    programs.kitty = {
      enable = true;

      extraConfig = ''
        # vim:ft=kitty

        placement_strategy top-left
        allow_remote_control yes

        font_size 9

        font_family Fira Code
        bold_font auto
        italic_font auto
        bold_italic_font auto

        # goddamn it
        enable_audio_bell no


        # Cursor shape
        cursor_shape block
        shell_integration no-cursor

      '';
    };
  };
}
