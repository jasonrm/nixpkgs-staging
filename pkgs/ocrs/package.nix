{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "ocrs";
  version = "0.10.4";

  src = fetchFromGitHub {
    owner = "robertknight";
    repo = "ocrs";
    rev = "ocrs-v${version}";
    hash = "sha256-WLzaCWojaa8WPtxg3D47HNjhpQYurU6Tg/Y0WYQJbXs=";
  };

  cargoHash = "sha256-8KKkFksp7rgax3ahdEw4xZxqdRTdg4NKZrsO2avvmrg=";

  meta = with lib; {
    description = "CLI tool for extracting text from images using the ocrs OCR engine";
    homepage = "https://github.com/robertknight/ocrs";
    license = [
      licenses.mit
      licenses.apsl20
    ];
  };
}
