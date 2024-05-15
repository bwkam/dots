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
      settings = {
        font_size = "11.0";
      };
      extraConfig = ''
        # vim:ft=kitty

        placement_strategy top-left
        allow_remote_control yes

        font_family Iosevka Medium
        bold_font Iosevka Bold
        italic_font Iosevka Light italic
        bold_italic_font Iosevka Bold Italic


        # Cursor shape
        cursor_shape block
        shell_integration no-cursor

      '';
    };
  };
}
