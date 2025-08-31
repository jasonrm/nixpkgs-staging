{
  lib,
  stdenv,
  fetchFromGitHub,
  libiconv,
  rustPlatform,
  darwin,
}:
rustPlatform.buildRustPackage rec {
  pname = "ocrs";
  version = "c0f8ae6f24f1dc71980a7505613231c2665829dd";

  src = fetchFromGitHub {
    owner = "robertknight";
    repo = "ocrs";
    rev = "${version}";
    hash = "sha256-WLzaCWojaa8WPtxg3D47HNjhpQYurU6Tg/Y0WYQJbXs=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-8KKkFksp7rgax3ahdEw4xZxqdRTdg4NKZrsO2avvmrg=";
  # cargoHash = lib.fakeHash;

  # buildInputs = [ libiconv ];

  meta = with lib; {
    description = "CLI tool for extracting text from images using the ocrs OCR engine";
    homepage = "https://github.com/robertknight/ocrs";
    license = [
      licenses.mit
      licenses.apsl20
    ];
    # maintainers = [ maintainers.havvy ];
  };
}
