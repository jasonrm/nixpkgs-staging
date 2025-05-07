{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "imaptar";
  version = "v1.4";

  src = fetchFromGitHub {
    owner = "XS4ALL";
    repo = pname;
    rev = version;
    sha256 = "1zxbg1a96z3j0fjqp93akw0bw93hqklgwmdkm6ngc7fc98r0lalg";
    # sha256 = lib.fakeSha256;
  };

  vendorHash = "0q8z6ym0sw5ajafymzkkbq0vzdjwwkrgr547xyai029m95vv1cgj";
  # vendorHash = lib.fakeHash;

  meta = with lib; {
    description = "utility to dump imap mailbox to a tarfile (maildir format)";
    license = licenses.asl20;
    homepage = "https://github.com/XS4ALL/imaptar";
    maintainer = ["jason@mcneil.dev"];
  };
}
