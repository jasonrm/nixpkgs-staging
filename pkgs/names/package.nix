{
  stdenv,
  lib,
  fetchFromGitHub,
  rustPlatform,
  postgresql,
  sqlite,
  mariadb,
  darwin,
  libiconv,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "names";
  version = "v0.12.0";

  src = fetchFromGitHub {
    owner = "fnichol";
    repo = pname;
    rev = version;
    hash = "sha256:1ih5alil8193gz9gjgakhly9l072g36a02xc6zh3jdgb1bzgcxrp";
    # cargoHash = lib.fakeSha256;
  };

  cargoHash = "sha256:0qrx7x3wcmw794yzpgzip4fxhrl48h2syig7wvn6w6rhrl51zl37";
  # cargoHash = lib.fakeSha256;

  nativeBuildInputs = [
    pkg-config
  ];

  # buildInputs = [
  #   postgresql.lib
  #   openssl
  #   sqlite
  #   mariadb.client
  # ] ++ lib.optionals stdenv.isDarwin [
  #   darwin.apple_sdk.frameworks.Security
  #   libiconv
  # ];

  # cargoBuildFlags = [
  #   "--features postgres,sqlite,mysql"
  # ];

  meta = with lib; {
    description = "Random name generator";
    homepage = "https://github.com/fnichol/names";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
