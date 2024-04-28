let
  bwkam =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSzkiNAGK0+R7lYXdGinTMHWlenVkhAK8C2csDqnPrG";

in { "github.age".publicKeys = [ bwkam ]; }
