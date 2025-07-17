{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  imagemagick,
}:
rustPlatform.buildRustPackage rec {
  pname = "folderify";
  version = "4.1.1";

  src = fetchFromGitHub {
    owner = "lgarron";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-mC4Fc/gY6iqmgrghaXu6xAaITs+nrMBUdICoeq0Az6g=";
  };

  cargoHash = "sha256-W1H7F8LNJ8Z9Ir/eDianp2GSr68maziT/4GxkM/5HFc=";

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
