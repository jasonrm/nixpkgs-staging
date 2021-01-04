{ lib
, fetchFromGitHub
, rustPlatform
}:
rustPlatform.buildRustPackage rec {
  pname = "redis-cell";
  version = "v0.2.5";

  src = fetchFromGitHub {
    owner = "brandur";
    repo = pname;
    rev = version;
    sha256 = "000sdb1b8ilypr9k3bmam9q50bx0dwancpihh4p1wxa38b0l4spm";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "0aqq8i997zfa40ddi9q677dlgls59fq3fl0mqanj1ixv99paj27g";
  # cargoSha256 = lib.fakeSha256;

  cargoPatches = [
    ./Cargo.lock.patch
  ];

  meta = with lib; {
    description = "A Redis module that provides rate limiting in Redis as a single command.";
    license = licenses.mit;
    homepage = "https://github.com/brandur/redis-cell";
    # maintainers = [ maintainers.SuperSandro2000 ];
  };
}
