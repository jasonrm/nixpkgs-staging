{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "migrate-dsql";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-LMLYVq9Oiczt6uC5vpn86lKWf9AFmRjf16inZzMeZKI=";
  };

  cargoHash = "sha256-XUBxD4zxyRZhB/iStnA0JyZ7vAPnz/JDKQO/3fkplio=";

  meta = with lib; {
    description = "A database migration tool specifically designed for Amazon Aurora DSQL";
    homepage = "https://github.com/bitnixdev/migrate-dsql";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    mainProgram = "migrate-dsql";
  };
}
