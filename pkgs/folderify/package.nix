{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  imagemagick,
}:
rustPlatform.buildRustPackage rec {
  pname = "folderify";
  version = "4.1.3";

  src = fetchFromGitHub {
    owner = "lgarron";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Gq6rXqvvnFmAzKxnoJ70x2zLA4h/P0hjMMldNMc6jtI=";
  };

  cargoHash = "sha256-XyNcWwqy4w+b/epvjx6Jt7IBoZgxfowLOWeC6pMvaVo=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ imagemagick ];

  meta = with lib; {
    description = "Generate pixel-perfect macOS folder icons in the native style";
    homepage = "https://github.com/lgarron/folderify";
    license = licenses.mit;
    maintainers = [ "jason@mcneil.dev" ];
    platforms = platforms.darwin;
  };
}
