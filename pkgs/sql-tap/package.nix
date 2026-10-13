{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "sql-tap";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "mickamy";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-jCxivoQHmmOKlesHiyCJRqm25N6SCmMIJQDDs0kA5Zg=";
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
