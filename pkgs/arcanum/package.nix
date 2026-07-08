{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-rcjeYTmq7v+8NgB9HrQYJ+I2TgqM3c7qxMrPN2iY6Ws=";
  };

  cargoHash = "sha256-tLbGbHVafq/8ztS7BfVXA9lOCWDdrEh5F8qnkzoR7Qg=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
