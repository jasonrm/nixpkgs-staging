{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  imagemagick,
}:
rustPlatform.buildRustPackage rec {
  pname = "folderify";
  version = "4.1.4";

  src = fetchFromGitHub {
    owner = "lgarron";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Gdi0TBdglbT1/TGLM80sSocGywfq8J5LSk6o3GZ3h1U=";
  };

  cargoHash = "sha256-SDbvE/S0ja0w5Su7/a9aZExJQoAkybnu//ERLtpOjMI=";

  nativeBuildInputs = [pkg-config];

  buildInputs = [imagemagick];

  meta = with lib; {
    description = "Generate pixel-perfect macOS folder icons in the native style";
    homepage = "https://github.com/lgarron/folderify";
    license = licenses.mit;
    maintainers = ["jason@mcneil.dev"];
    platforms = platforms.darwin;
  };
}
