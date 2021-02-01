{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, darwin
}:
buildGoModule rec {
  pname = "uritool";
  version = "v1.1.0";

  src = fetchFromGitHub {
    owner = "adrianrudnik";
    repo = "uritool";
    rev = version;
    sha256 = "0ixjrlmyzhn9jhj07mzrm4xk9p7vdvyyisx108wgrbmjmmmf3i2m";
    # sha256 = lib.fakeSha256;
  };

  # vendorSha256 = "1han6mm61r0lksbyb81yrfp0pnsf5rw6lj9h6y6hxd5blqinskq5";
  # vendorSha256 = lib.fakeSha256;
  vendorSha256 = null;

  buildInputs = [
  ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreFoundation ];

  meta = with lib; {
    description = "command-line tool that helps with URI/URL handling and proper part extraction, escaping and parsing";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = ["jason@mcneil.dev"];
  };
}
