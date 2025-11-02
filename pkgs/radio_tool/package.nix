{
  stdenv,
  fetchFromGitHub,
  libusb1,
  pkg-config,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "radio_tool";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "v0l";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-mdl0Z6bzuEbULXG0qW+Gfpk+adafOlXvPihUNJlwty8=";
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
