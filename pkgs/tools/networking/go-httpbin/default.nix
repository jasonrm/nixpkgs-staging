{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  darwin,
}:
buildGoModule rec {
  pname = "go-httpbin";
  version = "2.13.1";

  src = fetchFromGitHub {
    owner = "mccutchen";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-whKFbE9v00bywDW59wnf0MtxQEaJLOqspVefVZz1Q7A=";
    # hash = lib.fakeHash;
  };

  vendorHash = null;

  subPackages = ["cmd/go-httpbin"];

  meta = with lib; {
    description = "A reasonably complete and well-tested golang port of httpbin, with zero dependencies outside the go stdlib. ";
    license = licenses.mit;
    homepage = "https://github.com/mccutchen/go-httpbin";
    maintainer = ["jason@mcneil.dev"];
  };
}
