{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "migrate";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-7JeeJlPXg4uxdZiWYpcog+YUtWnWdMQbiDx2PJXDMbc=";
  };

  cargoHash = "sha256-ElHfH8rj9UM6jkLszEPgsGqA49R3KZOXk5hbms988zE=";

  meta = with lib; {
    description = "Database migration tool for Postgres, MySQL, SQLite, and Amazon Aurora DSQL";
    homepage = "https://github.com/bitnixdev/migrate";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    mainProgram = "migrate";
  };
}
