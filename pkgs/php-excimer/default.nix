{
  buildPecl,
  lib,
  zlib,
  pkg-config,
  fetchFromGitHub,
}: let
  pname = "excimer";
  version = "1.2.1";
in
  buildPecl {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "wikimedia";
      repo = "mediawiki-php-excimer";
      rev = version;
      hash = "sha256-eJ1DhJMAnNHSNDm+oIBvmtpYxBDDMwFpxaxLhjNZ8Ak=";
      # hash = lib.fakeHash;
    };

    # nativeBuildInputs = [pkg-config];
    # buildInputs = [zlib];

    meta = with lib; {
      description = "Excimer is an extension for PHP 7.1+ that provides a low-overhead interrupting timer and sampling profiler.";
      license = licenses.asl20;
      homepage = "https://www.mediawiki.org/wiki/Excimer";
    };
}
