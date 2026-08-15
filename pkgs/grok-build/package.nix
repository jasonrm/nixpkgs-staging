# Grok CLI (grok-build) — prebuilt binaries from x.ai
#
# Discover new versions (same mechanism as https://x.ai/cli/install.sh):
#   curl -fsSL https://x.ai/cli/stable          # default channel → version string
#   curl -fsSL https://x.ai/cli/alpha           # prerelease
#   curl -fsSL https://x.ai/cli/enterprise      # enterprise channel
# Fallback if x.ai is unreachable:
#   curl -fsSL https://storage.googleapis.com/grok-build-public-artifacts/cli/stable
#
# Artifact URL pattern (used below):
#   https://storage.googleapis.com/grok-build-public-artifacts/cli/grok-${version}-${platform}
# Platforms: macos-aarch64, linux-aarch64, linux-x86_64
# (macos-x86_64 is not published; primary host is also https://x.ai/cli/…)
#
# After bumping version, set each asset.hash to "" and rebuild to get the real hashes.
{
  lib,
  stdenv,
  fetchurl,
}: let
  version = "1.0.4";

  # macos-x86_64 (Intel) is not currently published by upstream; only Apple Silicon + Linux are provided.
  assets = {
    "aarch64-darwin" = {
      platform = "macos-aarch64";
      hash = "sha256-OTZvd1agkLc1zB34yTqMDDx4cVVc9suyj5NRyoKTZIU=";
    };
    "aarch64-linux" = {
      platform = "linux-aarch64";
      hash = "sha256-CK9SSZ97SkoJTGXslgvp+GLiUoobII5RQd65jB2FOI8=";
    };
    "x86_64-linux" = {
      platform = "linux-x86_64";
      hash = "sha256-efSWJfFTkj20kaXCkOmwTDRE2kiLa51qrFM8y1v/JFU=";
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
