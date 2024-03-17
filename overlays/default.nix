{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      pywal = pkgs.pywal.overrideAttrs
        (final: prev: { patches = (prev.patches or [ ]) ++ [ ./fish.patch ]; });
    })
  ];
}
