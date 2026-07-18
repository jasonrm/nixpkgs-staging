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
    version = "0.3.1";

    src = fetchFromGitHub {
      owner = "home-operations";
      repo = "drm-exporter";
      rev = version;
      hash = "sha256-CenwDf4Wp/HsNSBreXuckXlpr6pIgJQda7rgYHCk2uY=";
    };

    cargoHash = "sha256-UKRmZQuY+PHityVJwREdNpdQIVs351Y4jbO6IsKhUIM=";

    env.DRM_EXPORTER_VERSION = version;

    postPatch = ''
      substituteInPlace Cargo.toml --replace-fail 'rust-version = "1.97.0"' 'rust-version = "1.95.0"'
    '';

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
