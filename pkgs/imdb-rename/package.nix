{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "imdb-rename";
  version = "0.0.0-unstable-2024-09-25";

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = pname;
    rev = "f4180e5d89b5dd6f83142f7c8a7c8b439ab80ab1";
    hash = "sha256-xmWF37mt0hwfSwoKFzJbLujHTsM9X1PDhWV9MuTP9/g=";
  };

  cargoHash = "sha256-g1kTQvrUvfakFJ3+BmFqFXlsH4uEiZK6KCEa0BG0mSI=";

  meta = with lib; {
    description = "A command line tool to rename media files based on titles from IMDb";
    homepage = "https://github.com/BurntSushi/imdb-rename";
    license = licenses.unlicense;
    maintainer = ["jason@mcneil.dev"];
  };
}
