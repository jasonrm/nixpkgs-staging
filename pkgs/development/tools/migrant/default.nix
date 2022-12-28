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
  pname = "migrant";
  version = "v0.14.0";

  src = fetchFromGitHub {
    owner = "jaemk";
    repo = pname;
    rev = "846bfd7a5e2e52df92ce619246d4a1331ec5d515"; # untagged v0.14.0
    sha256 = "1gqlai0wh7rgp62l6w0ipb2mhbmraknya04p3ngplcv1hn3cablj";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "0pkih2piii7k524qn1irq1rb0l93pblmggxv6s1d57dn6krvm78z";
  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      postgresql.lib
      openssl
      sqlite
      mariadb.client
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      libiconv
    ];

  cargoBuildFlags = [
    "--features postgres,sqlite,mysql"
  ];

  meta = with lib; {
    description = "Migration management for PostgreSQL/SQLite/MySQL";
    homepage = "https://github.com/jaemk/migrant";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
