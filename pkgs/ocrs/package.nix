{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "ocrs";
  version = "0.12.1";

  src = fetchFromGitHub {
    owner = "robertknight";
    repo = "ocrs";
    rev = "ocrs-v${version}";
    hash = "sha256-ow7e4KulCKVPlKTTBsSBmbyNwiOQxBsnK3Fk4uuRpQg=";
  };

  cargoHash = "sha256-w57NPTMu9DkEv2vT7KShgzD96Lp5/suIxbSs4Twq2lQ=";

  cargoBuildFlags = [
    "--features clipboard"
  ];

  meta = with lib; {
    description = "CLI tool for extracting text from images using the ocrs OCR engine";
    homepage = "https://github.com/robertknight/ocrs";
    license = [
      licenses.mit
      licenses.apsl20
    ];
  };
}
