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
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-dGJM0w77LfBBD8tXi1ysdF6AYcKTRc0W35l0+bpJF5M=";
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

  cargoHash = "sha256-If9YxAjblfyJ+N5pbZtwCrCcaGQCxjhu2HZ0VWWXMkM=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
