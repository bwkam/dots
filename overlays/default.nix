{ pkgs, ... }:

(final: prev: {
  pywal = prev.python310Packages.buildPythonPackage {
    pname = "pywal";
    version = "3.5.0";
    propogatedBuildInputs = with prev; [
      imagemagick
      feh
      python310Packages.colorthief
      colorz
    ];
    src = builtins.fetchGit {
      url = "https://github.com/eylles/pywal16";
      rev = "806d0268a75eb17d1bc60ad81f00500e56097d3d";
    };
    doCheck = false;
  };
  wallust = prev.wallust.overrideAttrs (final: prev: {
    version = "3.0.0-beta";
    cargoDeps = prev.cargoDeps.overrideAttrs (final: prev: {
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "explosion-mental";
        repo = "wallust";
        rev = "104d99fcb4ada743d45de76caa48cd899b021601";
        hash = "sha256-gGyxRdv2I/3TQWrTbUjlJGsaRv4SaNE+4Zo9LMWmxk8=";
      };
    });
  });
})
