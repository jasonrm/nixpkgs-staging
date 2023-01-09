{
  description = "dev.mcneil.nix.nixpkgs-staging";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }: let
    inherit (nixpkgs.lib) hasSuffix;
    inherit (nixpkgs.lib.filesystem) listFilesRecursive;
    inherit (utils.lib) eachDefaultSystem;

    onlyNix = baseName: (hasSuffix ".nix" baseName);
    nixosModules = builtins.filter onlyNix (listFilesRecursive ./nixosModules);

    allPackages = import ./pkgs;
    packages = eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        legacyPackages = allPackages {
          inherit pkgs;
          lib = pkgs.lib;
        };
      }
    );
  in
    packages
    // {
      nixosModules.default = {
        nixpkgs.overlays = [
          (final: prev:
            allPackages {
              pkgs = prev;
              lib = prev.lib;
            })
        ];
        imports = nixosModules;
      };
      overlays.default = final: prev:
        allPackages {
          pkgs = prev;
          lib = prev.lib;
        };
    };
}
