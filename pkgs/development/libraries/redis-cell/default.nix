{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "redis-cell";
  version = "v0.3.0";

  src = fetchFromGitHub {
    owner = "brandur";
    repo = pname;
    rev = version;
    sha256 = "1s240lgshign1jkdr6bs5jv1mr0wygpl3al6a9l9kqqlkyrwzbj7";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "1b47nax0gdiw4ngh2d00rz6mnhm06f8pyydrbczyx0hkyxdv3zml";
  # cargoSha256 = lib.fakeSha256;

  cargoPatches = [
    ./Cargo.lock.patch
  ];

  meta = with lib; {
    description = "A Redis module that provides rate limiting in Redis as a single command.";
    license = licenses.mit;
    homepage = "https://github.com/brandur/redis-cell";
    maintainer = ["jason@mcneil.dev"];
  };
}
