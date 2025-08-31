{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) listToAttrs hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;

  onlyDefaultNix = baseName: (hasSuffix "package.nix" baseName);
  packageDefinitions = builtins.filter onlyDefaultNix (listFilesRecursive ./.);

  packages = listToAttrs (
    map (name: {
      name = builtins.baseNameOf (builtins.dirOf name);
      value = pkgs.callPackage name {};
    })
    packageDefinitions
  );
in
  packages
  // {
    customLib = pkgs.callPackage ./lib {};

    yubikey-agent = pkgs.callPackage "${pkgs.path}/pkgs/by-name/yu/yubikey-agent/package.nix" {
      buildGoModule = args:
        pkgs.buildGoModule (
          args
          // {
            src = pkgs.fetchFromGitHub {
              owner = "jasonrm";
              repo = "yubikey-agent";
              rev = "9a64bd0ca5b05b8a685a0f83e2a7d0a01f7489dd";
              hash = "sha256-Wbm569DqVf7q8zg3lvWdgGaS6IFS9FSxfvD98zc/I14=";
            };

            vendorHash = "sha256-ZQCxW+NDeYJofC9/9z8BpcRtBJ5p7hfQfsaX7iRIw5w=";
          }
        );
    };
  }
