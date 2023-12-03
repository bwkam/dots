{ lib, config, pkgs, ... }:

self: super:

with super;

let
  haxe = with rec {
    version = "4.3.1";
    haxeTarLink =
      "https://github.com/HaxeFoundation/haxe/releases/download/${version}/haxe-${version}-linux64.tar.gz";
    haxeTar = builtins.fetchTarball {
      url = haxeTarLink;
      sha256 = "sha256:14a7p6wm0whdl1di6h64g5mxr3qlgg2q580xigv3kmyrhzj0v5br";
    };
  };
    stdenv.mkDerivation {
      name = "haxe-${version}";
      system = "x86_64-linux";
      inherit version;
      src = "${haxeTar}";
      nativeBuildInputs = [ autoPatchelfHook ];
      unpackPhase = false;
      buildInputs = [ glibc gcc-unwrapped neko ];
      installPhase = ''
        mkdir -p $out/bin
        cp -av $src/* $out/bin
      '';
      meta = {
        description = "Haxe 4.3.1";
        homepage = "https://haxe.org/";
        license = lib.licenses.gpl2Plus;
        platforms = [ "x86_64-linux" ];
      };
    };
in { inherit haxe; }

