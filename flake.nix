{
  description = "dev.mcneil.nix.nixpkgs-staging";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    utils,
    ...
  }: let
    inherit (nixpkgs.lib) hasSuffix;
    inherit (nixpkgs.lib.filesystem) listFilesRecursive;
    inherit (utils.lib) eachDefaultSystem;

    onlyNix = baseName: (hasSuffix ".nix" baseName);
    nixosModules = builtins.filter onlyNix (listFilesRecursive ./nixosModules);

    allPackages = import ./pkgs;
    perSystem = eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        legacyPackages = allPackages {
          inherit pkgs;
          nixpkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          lib = pkgs.lib;
        };
        devShell = pkgs.mkShell {buildInputs = with pkgs; [node2nix];};
      }
    );
  in
    perSystem
    // {
      nixosModules.default = {
        nixpkgs.overlays = [
          (
            final: prev:
              allPackages {
                pkgs = prev;
                lib = prev.lib;
              }
          )
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
