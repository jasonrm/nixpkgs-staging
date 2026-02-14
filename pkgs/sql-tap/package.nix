{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "sql-tap";
  version = "0.0.5";

  src = fetchFromGitHub {
    owner = "mickamy";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-VlJ6VlIl9rE1bjPLy0uEtqxmrYYtPq2QJ1tVITmRnI8=";
  };

  vendorHash = "sha256-zf3NxbxX8X2/ZHBDjbp+cPOviODLTTDrY1LW//3lSDk=";

  # Tests require Docker via testcontainers.
  doCheck = false;

  meta = with lib; {
    description = "";
    license = licenses.mit;
    homepage = "https://github.com/mickamy/sql-tap";
    maintainer = ["jason@mcneil.dev"];
  };
}
