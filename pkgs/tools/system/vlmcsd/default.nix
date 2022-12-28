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
    rev = "e599080486478e219cd065e141d6de050a450c27";
    sha256 = "19qfw4l4b5vi03vmv9g5i7j32nifvz8sfada04mxqkrqdqxarb1q";
    # hash = lib.fakeSha256;
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
