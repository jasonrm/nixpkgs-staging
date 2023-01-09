{
  pkgs,
  lib,
}: let
  trivial = pkgs.callPackage ./trivial.nix {};
in {
  inherit (trivial) aliasToPackage;
}
