{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) listToAttrs hasSuffix makeExtensible functionArgs intersectAttrs;
  inherit (lib.filesystem) listFilesRecursive;

  onlyDefaultNix = baseName: (hasSuffix "package.nix" baseName);
  packageDefinitions = builtins.filter onlyDefaultNix (listFilesRecursive ./.);

  # Filters arguments to only what the package function expects
  callPackageFiltered = packageFile: extraArgs: let
    packageFunc = import packageFile;
    expectedArgs = functionArgs packageFunc;
    # Merge pkgs and extraArgs, then filter to only expected arguments
    allArgs = pkgs // extraArgs;
    filteredArgs = intersectAttrs expectedArgs allArgs;
  in
    packageFunc filteredArgs;

  # Create a self-referential package set using makeExtensible
  packages = makeExtensible (self: let
    packageSet = listToAttrs (
      map (name: {
        name = builtins.baseNameOf (builtins.dirOf name);
        value = callPackageFiltered name self;
      })
      packageDefinitions
    );
  in
    packageSet
    // {
      customLib = callPackageFiltered ./lib self;

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
    });
in
  packages
