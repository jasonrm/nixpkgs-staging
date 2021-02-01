{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, openssl
, libssh2
, zlib
}:
rustPlatform.buildRustPackage rec {
  pname = "ssh-permit-a38";
  version = "v0.2.0";

  src = fetchFromGitHub {
    owner = "ierror";
    repo = pname;
    rev = version;
    sha256 = "0rqrw2xb8v0a39jjzi5lgwj4hcmcvqbkbm45k0ppxxjn4cp80myx";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "1gsb418darxppm557q99ikim886xw03wd9pxk3ywwsy4kxrxd54s";
  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl libssh2 zlib ];

  # Tests use the same backing JSON file
  cargoParallelTestThreads = false;

  meta = with lib; {
    description = "Central management and deployment for SSH keys";
    homepage = "https://github.com/ierror/ssh-permit-a38";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
