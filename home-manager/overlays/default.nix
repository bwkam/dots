{ pkgs }: {
  modifications = final: prev: {
    discord = prev.callPackage ./discord.nix;
  };
}

