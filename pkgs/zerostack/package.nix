{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "zerostack";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "gi-dellav";
    repo = "zerostack";
    rev = "v${version}";
    hash = "sha256-nqz4SKCtNPJLaHGU1nZS8neH0dVoKjLOdC0Gjfs53pE=";
  };

  cargoHash = "sha256-AI7CIZNpwql78QIFitNimLFi+FGeOO3espXFkEyHRjI=";

  meta = {
    description = "Minimalistic coding agent written in Rust, optimized for memory footprint and performance";
    homepage = "https://github.com/gi-dellav/zerostack";
    license = lib.licenses.gpl3Only;
    maintainers = [];
    mainProgram = "zerostack";
  };
}
