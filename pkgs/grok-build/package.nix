{
  lib,
  stdenv,
  fetchurl,
}: let
  version = "0.2.51";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-HKq1jrJeGtdrMJFUrNJkOnCZJHVV4QP+OsY/Q4gJmoI=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-GteXTXOGrDfF/Pz47u32FAO2E01PVhtAxZM0Ii9sV4s=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-UpFiZ6oveGjCOm3XhH3+Bm45pSuP/SFjgBhjl+p9AHU=";
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
