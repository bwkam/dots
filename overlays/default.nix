{ pkgs, lib, inputs, ... }:

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

  wallust = with (inputs.nixpkgs-unstable.legacyPackages."x86_64-linux");
    let
      rustPlatform = makeRustPlatform {
        rustc = rustc;
        cargo = cargo;
      };
    in (prev.wallust.override { inherit rustPlatform; }).overrideAttrs
    (final: prev:
      let
        src = pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "explosion-mental";
          repo = "wallust";
          rev = "3.0.0-beta";
          hash = "sha256-gGyxRdv2I/3TQWrTbUjlJGsaRv4SaNE+4Zo9LMWmxk8=";
        };
      in {
        version = "v3.0.0-beta";
        inherit src;
        cargoDeps = prev.cargoDeps.overrideAttrs (final: prev: {
          inherit src;
          outputHash = "sha256-99rCet2XV/L0e/wAoIMoJTvNfU456MdbEFpuKnX0ABI=";
        });
      });
})
