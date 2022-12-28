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
    inherit (nixpkgs.lib) evalModules hasSuffix nameValuePair;
    inherit (nixpkgs.lib.filesystem) listFilesRecursive;
    inherit (utils.lib) eachSystem eachDefaultSystem;

    onlyNix = baseName: (hasSuffix ".nix" baseName);
    nixosModules = builtins.filter onlyNix (listFilesRecursive ./nixosModules);

    packages = (eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      in import ./pkgs { inherit pkgs; }
    ));
  in
    {
      inherit packages;
      nixosModules.default = {
        imports = nixosModules;
      };
      overlays.default = final: prev: import ./pkgs {
        pkgs = prev;
      };
    };
}
