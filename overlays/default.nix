{ pkgs, ... }:

[
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
  })
]
