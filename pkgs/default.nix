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
              version = "0.1.6.2";
              src = pkgs.fetchFromGitHub {
                owner = "jasonrm";
                repo = "yubikey-agent";
                rev = "v0.1.6.2";
                hash = "sha256-T/TpshANaV6Nsd5VainGXdm98LzB5O3tTDPBxY+3k+M=";
              };

              vendorHash = "sha256-V0ztKsSGzlFc45AcCIEPiEgcWNsKE6u/KMbp8Z+zB8U=";
            }
          );
      };
    });
in
  packages
