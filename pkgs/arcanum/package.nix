{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-XyNeFCoi4cv6jP/4el0c5ZqXI5JyM4UBmVj+3Jc3OmE=";
  };

  cargoHash = "sha256-T1BeOQcHAAbO36EsWZOutZT3xAAdDQtrR4ZnxMYXVYg=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
