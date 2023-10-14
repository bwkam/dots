{ pkgs
, config
, ...
}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "pink"; };
    };

    theme = {
      name = "Catppuccin-Mocha-Standard-Pink-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        # tweaks = ["rimless"];
        variant = "mocha";
      };
    };
  };
}
