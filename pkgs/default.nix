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
        name = baseNameOf (dirOf name);
        value = callPackageFiltered name self;
      })
      packageDefinitions
    );
  in
    packageSet
    // {
      customLib = callPackageFiltered ./lib self;

      yubikey-agent = pkgs.callPackage "${pkgs.path}/pkgs/by-name/yu/yubikey-agent/package.nix" {
        buildGoModule = args: let
          # Handle both legacy (attrset) and new (finalAttrs functor) calling conventions
          resolvedArgs =
            if builtins.isFunction args
            then args
            else (_finalAttrs: args);
        in
          pkgs.buildGoModule (
            finalAttrs:
              resolvedArgs finalAttrs
              // {
                version = "0.1.6.3";
                src = pkgs.fetchFromGitHub {
                  owner = "jasonrm";
                  repo = "yubikey-agent";
                  rev = "dc00d22f";
                  hash = "sha256-SmsMGUqkIQ9us3je8/nNV83M6MO5DyZscAw3nOVEZQc=";
                };

                vendorHash = "sha256-tzeeqRgcCAOAFiHHotFkBuW5OEUHmIVvbnXSzycQldQ=";
              }
          );
      };
    });
in
  packages
