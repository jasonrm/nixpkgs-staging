# Do not use overrides in this file to add  `meta.mainProgram` to packges. Use `./main-programs.nix`
# instead.
{
  pkgs,
  nodejs,
}: let
  inherit
    (pkgs)
    stdenv
    lib
    callPackage
    fetchFromGitHub
    fetchurl
    fetchpatch
    nixosTests
    ;

  since = version: lib.versionAtLeast nodejs.version version;
  before = version: lib.versionOlder nodejs.version version;
in
  final: prev: {
    tslab = prev.tslab.override (oldAttrs: {
      # loosely based on ijavascript & tedicross
      preRebuild = ''
        export npm_config_zmq_external=true
      '';
      buildInputs =
        oldAttrs.buildInputs
        ++ (with pkgs; [zeromq libsodium czmq])
        # ++ lib.optionals stdenv.isDarwin (with pkgs.darwin.apple_sdk.frameworks; [
        #   CoreText
        # ]
        ;
      nativeBuildInputs = with pkgs; [pkg-config];
    });
  }
