{ pkgs, config, lib, ... }:

{
  discord = pkgs.discord.override {
    withOpenASAR = true;
    withVencord = true;
  };
}
