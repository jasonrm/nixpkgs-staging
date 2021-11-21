## Example Use

**flake.nix**
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    staging.url = "github:jasonrm/nixpkgs-staging";
  };

  outputs = { self, nixpkgs, utils, staging }:
    let
      inherit (nixpkgs.lib) evalModules;
      inherit (nixpkgs.lib.filesystem) listFilesRecursive;
      inherit (utils.lib) eachDefaultSystem;

      nixosModule = {
        imports = listFilesRecursive ./modules;
      };

      outputs = (eachDefaultSystem (system: (evalModules {
          specialArgs = { inherit nixpkgs system staging; };
          modules = [ nixosModule ];
        }).config.outputs));
    in
    outputs // {
      inherit nixosModule;
    };
}
```

**modules/pkgs.nix**
```nix
{ system, nixpkgs, staging, ... }:
{
  _module.args = {
    pkgs = import nixpkgs { inherit system; overlays = [ staging.overlay ]; };
  };
}
```