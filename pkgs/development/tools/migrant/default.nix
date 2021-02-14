{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, postgresql
, sqlite
, mariadb
, darwin
}:
rustPlatform.buildRustPackage rec {
  pname = "migrant";
  version = "v0.13.0";

  src = fetchFromGitHub {
    owner = "jaemk";
    repo = pname;
    rev = version;
    sha256 = "0nbzqx58zcz3bbrdxa75rcbz5s6h7r61l1nc2dbifa5vxf0wbmq2";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "1zhc5568p538kkb2i7q26agiqbqnh3fj23q2h79v30fqyjbrb1ms";
  # cargoSha256 = lib.fakeSha256;

  buildInputs = [
  postgresql.lib
  sqlite
  mariadb.client
  ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

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
