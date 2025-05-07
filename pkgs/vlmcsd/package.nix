{
  lib,
  stdenv,
  fetchFromGitHub,
  gcc,
}:
stdenv.mkDerivation rec {
  pname = "vlmcsd";
  version = "1113";

  src = fetchFromGitHub {
    owner = "Wind4";
    repo = "vlmcsd";
    rev = "70e03572b254688b8c3557f898e7ebd765d29ae1";
    hash = "sha256-BEi47U0rdkO+AlQRpntsaTgm5A4CSwS6LuffAl2kIaw=";
    # hash = lib.fakeHash;
  };

  installPhase = ''
    mkdir -p $out/bin

    for bin in vlmcs{d,}; do
      install -Dm755 bin/$bin $out/bin/$bin
    done

    pushd man
    for manpage in *.[0-9]; do
        section=''${manpage##*.}
        install -Dm644 "$manpage" "$out/share/man/man$section/$manpage"
    done
    popd
  '';

  buildInputs = [
    gcc
  ];

  meta = with lib; {
    description = "KMS Emulator in C";
    homepage = "https://github.com/Wind4/vlmcsd";
    # platforms = platforms.linux;
    maintainer = ["jason@mcneil.dev"];
  };
}
