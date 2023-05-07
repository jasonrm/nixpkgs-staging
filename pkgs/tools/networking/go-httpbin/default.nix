{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  darwin,
}:
buildGoModule rec {
  pname = "go-httpbin";
  version = "2.8.0";

  src = fetchFromGitHub {
    owner = "mccutchen";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Josk44k6e89g6Qq2iE1d2u5fVz1hHIXx/0lojBzLpQE=";
    # hash = lib.fakeHash;
  };

  vendorHash = "sha256-pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";
  # vendorHash = lib.fakeHash;

  subPackages = ["cmd/go-httpbin"];

  meta = with lib; {
    description = "A reasonably complete and well-tested golang port of httpbin, with zero dependencies outside the go stdlib. ";
    license = licenses.mit;
    homepage = "https://github.com/mccutchen/go-httpbin";
    maintainer = ["jason@mcneil.dev"];
  };
}
