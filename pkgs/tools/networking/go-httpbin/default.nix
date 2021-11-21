{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, darwin
}:
buildGoModule rec {
  pname = "go-httpbin";
  version = "2.2.2";

  src = fetchFromGitHub {
    owner = "mccutchen";
    repo = pname;
    rev = "v${version}";
    sha256 = "1pkyh5q9dbydgfym0lr41mj33qz2fh214xifv7r2qjrqf2khnyzw";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  # vendorSha256 = lib.fakeSha256;

  subPackages = [ "cmd/go-httpbin" ];

  meta = with lib; {
    description = "A reasonably complete and well-tested golang port of httpbin, with zero dependencies outside the go stdlib. ";
    license = licenses.mit;
    homepage = "https://github.com/mccutchen/go-httpbin";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
