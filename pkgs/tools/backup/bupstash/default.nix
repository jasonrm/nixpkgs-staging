{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libsodium
}:
rustPlatform.buildRustPackage rec {
  pname = "bupstash";
  version = "v0.6.4";

  src = fetchFromGitHub {
    owner = "andrewchambers";
    repo = pname;
    rev = version;
    sha256 = "013k8pr4865f5rp66fjf3a8069kmd29brxv0l20z571gy2kxs5p9";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "06ks8crggc7qjqx3llp0mrxn62f6frwfl13fyawg77z0g6wp293y";
  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libsodium ];

  meta = with lib; {
    description = "Easy and efficient encrypted backups";
    homepage = "https://github.com/andrewchambers/bupstash";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
