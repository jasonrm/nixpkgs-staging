{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Z10hoEnVsXFhpEjF84yofSKxGZlYUv37qpDbFRQsvH8=";
  };

  cargoHash = "sha256-HV6NcWWpgYtK4O4Hl2NRzdatAlb+etQwPzIudZ5CMZs=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
