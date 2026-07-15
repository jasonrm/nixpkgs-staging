{
  lib,
  stdenv,
  fetchurl,
}: let
  version = "0.2.101";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-hDFTjb2ZN5JA9Vi0i3ecZR1miwbXk8hzEa1TLEOVpOI=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-TC1uezENUN2p8bsBQ/BplQ26toAhw46QIq77cyq9Mxk=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-JVYpnN7Tf4HlTAJCDPp/Gi35/qtypEWGmg9VluFDszM=";
    };
  };

  asset = assets.${stdenv.hostPlatform.system} or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation {
    pname = "grok-build";
    inherit version;

    src = fetchurl {
      url = "https://storage.googleapis.com/grok-build-public-artifacts/cli/grok-${version}-${asset.platform}";
      hash = asset.hash;
    };

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp $src $out/bin/grok
      chmod +x $out/bin/grok
      ln -s grok $out/bin/agent

      runHook postInstall
    '';

    meta = with lib; {
      description = "Grok CLI and agent";
      homepage = "https://x.ai/";
      license = licenses.unfree;
      maintainers = ["jason@mcneil.dev"];
      platforms = builtins.attrNames assets;
      mainProgram = "grok";
    };
  }
