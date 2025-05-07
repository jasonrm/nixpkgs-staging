{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  protobuf,
  pkg-config,
  stdenv,
  darwin,
  gcc
}:
rustPlatform.buildRustPackage rec {
  pname = "sheety";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "potassium-shot";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-RStIXc5sW8RB2Hu/S1vM2u2DIkLosyEHm3HatgSqIAk=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    # protobuf
    # pkg-config
  ];

  cargoPatches = [ ./cargo-lock.patch ];

  # buildNoDefaultFeatures = true;
  # buildFeatures = [ "rustls-tls-webpki-roots" ];

  # buildInputs = [
  #   # openssl
  # ] ++ lib.optionals stdenv.isDarwin [
  #   darwin.apple_sdk.frameworks.SystemConfiguration
  #    gcc.cc.lib
  # ];

  # NIX_LDFLAGS = "-l${stdenv.cc.libcxx.cxxabi.libName}";

  cargoHash = "sha256-TdpcHg5Hw+UZbhvzidJAvuT8qtgUoC6lm+KVQQ2GmzU=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    description = "sprite-sheet manipulation.";
    homepage = "https://github.com/potassium-shot/sheety";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
