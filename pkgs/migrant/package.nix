{
  lib,
  zlib,
  fetchFromGitHub,
  rustPlatform,
  postgresql,
  sqlite,
  mysql84,
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
    hash = "sha256-ki7FhoVhM3qfHZcA5e1UuS5YxboRcEOFuS8fyEFUFL8=";
  };

  cargoHash = "sha256-R8Dmcp3FQnEO9d3bpBi0yMj5qGJbpebEAMKvFf2jo14=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    zlib
    postgresql.lib
    openssl
    sqlite
    mysql84.client
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
