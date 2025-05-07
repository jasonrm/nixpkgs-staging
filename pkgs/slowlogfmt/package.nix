{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "slowlogfmt";
  version = "cbe32ab65257e37f7e58e92181a2662a72960101";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = "slowlogfmt";
    rev = version;
    sha256 = "sha256-D8fRqRWtExQJ2mH5GIhAKtgCkOg5Lc9XmTLVPR52jUI=";
    # sha256 = lib.fakeSha256;
  };

  vendorHash = "sha256-ZQllOFz9IfjlqKYR0ydd3gXi2KGcRwuJRvMrnMGMjYs=";
  # vendorHash = lib.fakeHash;

  meta = with lib; {
    description = "MySQL slow log table to logfmt";
    license = licenses.mit;
    homepage = "https://github.com/jasonrm/slowlogfmt";
    maintainer = ["jason@mcneil.dev"];
  };
}
