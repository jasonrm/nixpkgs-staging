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
  pname = "arcanum";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-KJsvU/5XOKQa0g6LdobdB6x3wXTijom1w9BP4acSToU=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [ 
    # protobuf
    # pkg-config
  ];

  # buildNoDefaultFeatures = true;
  # buildFeatures = [ "rustls-tls-webpki-roots" ];

  buildInputs = [
    # openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  cargoHash = "sha256-smxtQ73l8vOzMKdsKbTl+LYawEZBP+IqZ+iupKzmtlk=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
