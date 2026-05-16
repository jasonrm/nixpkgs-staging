{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "0.1.211";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-Z3/ptilnS9yOR/ftAaZAFYz7z5O/c18HsC/QMIzxm6w=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-soPLcv3DFDNl4ET9f4Yw4UhFZA1NgUBLs2kFzHIJq8Y=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-kkX5ySGx+Rv7NO4u4ncVAAtl6UdyNUH/GmEurs5Gi9A=";
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
