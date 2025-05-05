{
  lib,
  stdenv,
  fetchFromGitHub,
  libusb1,
  pkg-config,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "radio_tool";
  version = "0.2.2+";

  src = fetchFromGitHub {
    owner = "v0l";
    repo = pname;
    rev = "a1108b5af04aad706dc9988db7cddad6d91434f5";
    hash = "sha256-Bs2Hkd12AsJ9wqHFGW9h5IEmK5R/rzkYjxbLzxdJWLQ=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    libusb1
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "AppleClang" "Clang"
  '';

  meta = {
    description = "Radio firmware tool";
    homepage = "https://github.com/v0l/radio_tool";
    maintainer = ["jason@mcneil.dev"];
  };
}
