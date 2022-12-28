{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  libsodium,
  libiconv,
}:
rustPlatform.buildRustPackage rec {
  pname = "bupstash";
  version = "v0.9.1";

  src = fetchFromGitHub {
    owner = "andrewchambers";
    repo = pname;
    rev = version;
    sha256 = "1n8qa8hfncf9fdd1hmq5blphi7zla1whisdci6x1az1isn2lcd0g";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "19rfxmrlx6kanlpk16qhrms0jcy0bxphbs49v57xyag852yy4lsk";
  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    libsodium
    libiconv
  ];

  meta = with lib; {
    description = "Easy and efficient encrypted backups";
    homepage = "https://github.com/andrewchambers/bupstash";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
