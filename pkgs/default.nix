{ pkgs, lib, ... }:
let
  inherit (lib) listToAttrs hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;

  onlyDefaultNix = baseName: (hasSuffix "package.nix" baseName);
  packageDefinitions = builtins.filter onlyDefaultNix (listFilesRecursive ./.);

  packages = listToAttrs (
    map (name: {
      name = builtins.baseNameOf (builtins.dirOf name);
      value = pkgs.callPackage name { };
    }) packageDefinitions
  );

  phpExtensions = {
    packageOverrides = final: prev: {
      extensions = prev.extensions // {
        excimer = pkgs.callPackage ./php-excimer { inherit (prev) buildPecl; };
      };
    };
  };
in
# libOverlay = lib // (import ./lib { inherit pkgs lib; });
packages
// {
  customLib = pkgs.callPackage ./lib { };

  # nodePackages = pkgs.nodePackages.extend (final: prev: (pkgs.callPackage ./node-packages { }));

  php = pkgs.php.override phpExtensions;
  php82 = pkgs.php82.override phpExtensions;
  php83 = pkgs.php83.override phpExtensions;

  yubikey-agent = pkgs.callPackage "${pkgs.path}/pkgs/by-name/yu/yubikey-agent/package.nix" {
    buildGoModule =
      args:
      pkgs.buildGoModule (
        args
        // {
          src = pkgs.fetchFromGitHub {
            owner = "jasonrm";
            repo = "yubikey-agent";
            rev = "9a64bd0ca5b05b8a685a0f83e2a7d0a01f7489dd";
            # hash = lib.fakeHash;
            hash = "sha256-Wbm569DqVf7q8zg3lvWdgGaS6IFS9FSxfvD98zc/I14=";
          };

          vendorHash = "sha256-ZQCxW+NDeYJofC9/9z8BpcRtBJ5p7hfQfsaX7iRIw5w=";
          # vendorHash = lib.fakeHash;
        }
      );
  };
}
