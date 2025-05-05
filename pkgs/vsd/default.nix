{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  protobuf,
  pkg-config,
  stdenv,
  darwin,
  gcc
}:
rustPlatform.buildRustPackage rec {
  pname = "vsd";
  version = "0.3.0+git";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    fetchSubmodules = true;
    rev = "dfa98ef60186ad54d01ac49b33ff12a4fe363fa7";
    hash = "sha256-erJotRPa0KFjt2cqK+KOLkKYzasvL03DitvWp0iLlf4=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [ 
    protobuf
    pkg-config
  ];

  buildNoDefaultFeatures = true;
  buildFeatures = [ "rustls-tls-webpki-roots" ];

  buildInputs = [
    # openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
     gcc.cc.lib
  ];

  NIX_LDFLAGS = "-l${stdenv.cc.libcxx.cxxabi.libName}";
  
  cargoHash = "sha256-amdc/NSJZ93kirfc7t87VFnifJiorLgwb23t2tfnEHo=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    description = "Download video streams served over HTTP from websites, DASH (.mpd) and HLS (.m3u8) playlists";
    homepage = "https://github.com/clitic/vsd";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
