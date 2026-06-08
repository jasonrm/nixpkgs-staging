{
  lib,
  stdenv,
  fetchurl,
}: let
  version = "0.2.33";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-ifFeGIepNtlhYCJj4kmZuQD/mjZGjizzKSQSjOS1LoA=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-Csl/20RdR5/skH2Zdv0FeuBwU7wHdXSRZ1iCp0lB88A=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-DAd7As5qRqZkm8G7eSva05acwbL6ZzCmTPm67opkKEM=";
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
