{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libsodium
, libiconv
}:
rustPlatform.buildRustPackage rec {
  pname = "bupstash";
  version = "v0.9.0";

  src = fetchFromGitHub {
    owner = "andrewchambers";
    repo = pname;
    rev = version;
    hash = "sha256-uA5XEG9nvqsXg34bqw8k4Rjk5F9bPFSk1HQ4Bv6Ar+I=";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "sha256-5RyCjm8Nxm82AFwIsWChcohrBGVDqc/oWDkrdcvKHV8=";
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
