{ lib
, stdenv
, fetchurl
}:
stdenv.mkDerivation rec {
  pname = "etherdfs";
  version = "20180203";

  src = fetchurl {
    url = "https://sourceforge.net/projects/etherdfs/files/ethersrv-linux/ethersrv-linux-${version}.tar.xz";
    sha256 = "06japxh6sv5fmm8q7ll2yj6455lr981l7qdb85z9wrv7hdak2vpw";
    # sha256 = lib.fakeSha256;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ethersrv-linux $out/bin/$bin
  '';

  # buildInputs = [
  #   gcc
  # ];

  meta = with lib; {
    description = "An ethernet-based file system for DOS";
    homepage = "http://etherdfs.sourceforge.net";
    # platforms = platforms.linux;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
