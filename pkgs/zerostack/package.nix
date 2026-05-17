{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "zerostack";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "gi-dellav";
    repo = "zerostack";
    rev = "v${version}";
    hash = "sha256-pZrFvBWEoMbLkQo7HKd7zYlQ2mXI5+T4sTdPg8icNUs=";
  };

  cargoHash = "sha256-KfAXQCch7vUFnUlsgNiv12kOJD1/ixyWylcI1vnuNXM=";

  meta = {
    description = "Minimalistic coding agent written in Rust, optimized for memory footprint and performance";
    homepage = "https://github.com/gi-dellav/zerostack";
    license = lib.licenses.gpl3Only;
    maintainers = [];
    mainProgram = "zerostack";
  };
}
