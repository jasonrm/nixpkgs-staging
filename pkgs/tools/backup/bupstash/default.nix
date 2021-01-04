{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libsodium
}:
rustPlatform.buildRustPackage rec {
  pname = "bupstash";
  version = "v0.6.2";

  src = fetchFromGitHub {
    owner = "andrewchambers";
    repo = pname;
    rev = version;
    sha256 = "1s1f5iyasx86c76f38bx13h6c9l3cbdzwi4r5l5ddsiq9raj4l0z";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "16k9fjn9k2hhk2iqf1bpmklba9181v192026m5s9aspqhgifzbyb";
  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libsodium ];

  meta = with lib; {
    description = "Easy and efficient encrypted backups";
    homepage = "https://github.com/andrewchambers/bupstash";
    license = licenses.mit;
  };
}
