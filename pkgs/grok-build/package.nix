{
  lib,
  stdenv,
  fetchurl,
}: let
  version = "0.2.3";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-g3UfYaFNyME9C14CxiPVMc472yyMkFyWiXqhX230cTI=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-qd0S4znFg52Gq3EC5Lm90NqzI4zSVMHMG1E3sm+v1os=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-KgxPXQtYpH8wwrOGHUZ3SDc0jG0/fiT02GJ7ylDdqcw=";
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
