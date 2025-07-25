{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-FtMEkH0D2msKQ8I2a35RZj1wMa5tD9sLO+YjX1ELzBw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-sEw+20qXQQ0F1UNJD6rIgjdYGFOrqg86EiWX1n0rJuU=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
