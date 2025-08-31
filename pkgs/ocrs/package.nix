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
    hash = "sha256-P+nOSlbcetxwEuuv64lmUEUB8fpBLUPd96+YBzD86u4=";
  };

  cargoHash = "sha256-NA7NR2iV83UxJGlpBg6Zy+fMwe3WP8VQKi89lWWoN5c=";

  meta = with lib; {
    description = "CLI tool for extracting text from images using the ocrs OCR engine";
    homepage = "https://github.com/robertknight/ocrs";
    license = [
      licenses.mit
      licenses.apsl20
    ];
  };
}
