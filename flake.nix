{
  description = "dev.mcneil.nix.nixpkgs-staging";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    utils,
    rust-overlay,
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
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [rust-overlay.overlays.default];
        };
      in let
        legacyPkgs = allPackages {
          inherit pkgs;
          lib = pkgs.lib;
        };
      in {
        # Expose under both legacyPackages (for overlays / backward compat)
        # and packages (for `nix build .#<name>`, `nix flake show`,
        # `nix-update --flake <name>`, etc.)
        inherit legacyPkgs;
        legacyPackages = legacyPkgs;
        packages = legacyPkgs;
        devShell = pkgs.mkShell {};
      }
    );
  in
    perSystem
    // {
      nixosModules.default = {
        nixpkgs.overlays = [
          rust-overlay.overlays.default
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
