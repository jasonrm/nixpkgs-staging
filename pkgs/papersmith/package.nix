{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "papersmith";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "benletchford";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-IuXvWW0IfKhlJPHVzqt60pVglZ0FT2dzFdvkSurYbMM=";
  };

  cargoHash = "sha256-+ACeKiV2heVlxT3akiP68P++zmIOV/kMPjT31S8KLi0=";

  meta = with lib; {
    description = "An AI-powered PDF renamer that uses OpenAI's models to intelligently rename PDF documents based on their content";
    homepage = "https://github.com/benletchford/papersmith";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    mainProgram = "papersmith";
    platforms = platforms.unix;
  };
}
