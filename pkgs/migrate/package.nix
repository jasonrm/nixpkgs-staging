{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "migrate";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-vlXNAvkE82oheH8TxJGv+uSHjjZW9/7J3iIY4iyPzwA=";
  };

  cargoHash = "sha256-81ghlM14g1ks5eoh7coe8a8rwHI1VocIU9uADuUyepo=";

  meta = with lib; {
    description = "Opinionated up-only database migration tool";
    homepage = "https://github.com/bitnixdev/migrate";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    mainProgram = "migrate";
  };
}
