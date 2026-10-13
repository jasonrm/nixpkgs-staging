{
  lib,
  fetchFromGitHub,
  makeRustPlatform,
  pkg-config,
  rust-bin,
  udev,
}: let
  rustToolchain = rust-bin.stable.latest.minimal;
  rustPlatform = makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "drm-exporter";
    version = "0.3.4";

    src = fetchFromGitHub {
      owner = "home-operations";
      repo = "drm-exporter";
      rev = version;
      hash = "sha256-rJjUSE6CezWfSJaMOetDynROaB5PlPowwNq9JyRGNcI=";
    };

    cargoHash = "sha256-0V7/U1bGRdCzts3idI/EZrHTBIy9WPlS14q7y5j3hx0=";

    env.DRM_EXPORTER_VERSION = version;

    nativeBuildInputs = [pkg-config];
    buildInputs = [udev];

    meta = with lib; {
      description = "Prometheus exporter for Intel and AMD GPU metrics";
      homepage = "https://github.com/home-operations/drm-exporter";
      license = licenses.agpl3Only;
      mainProgram = "drm-exporter";
      platforms = platforms.linux;
      maintainer = ["jason@mcneil.dev"];
    };
  }
