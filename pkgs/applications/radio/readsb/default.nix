{
  lib,
  stdenv,
  fetchFromGitHub,
  zlib,
  zstd,
  ncurses,
  libusb1,
  pkg-config,
  rtl-sdr,
  libbladeRF,
  libiio,
  libad9361,
}:
stdenv.mkDerivation rec {
  pname = "readsb";
  version = "3.14.1595";

  src = fetchFromGitHub {
    owner = "wiedehopf";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1iBCqRQIqRSiUuzzdr0GTg9f+ZUPoRs2ugy+R+F1SPM=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    zlib
    zstd
    ncurses
    libusb1
    rtl-sdr
    libbladeRF
    libiio
    libad9361
  ];

  makeFlags = [
    "READSB_VERSION=${version}"
    "RTLSDR=yes"
    "BLADERF=yes"
    "PLUTOSDR=yes"
    "TRACKS_UUID=yes"
  ];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 readsb $out/bin/$bin
  '';

  meta = with lib; {
    description = "ADS-B decoder swiss knife";
    homepage = "https://github.com/wiedehopf/readsb";
    platforms = platforms.linux;
    maintainer = ["jason@mcneil.dev"];
  };
}
