{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "imageproxy";
  version = "v0.11.2";

  src = fetchFromGitHub {
    owner = "willnorris";
    repo = pname;
    rev = version;
    hash = "sha256-NDrsViOprpWFUkCKDPnZsFRuk0IxrtEhK4YrHH9KQcQ=";
    # sha256 = lib.fakeHash;
  };

  vendorHash = "sha256-u9CqQGmrOVqnEiXK4Dm6XPJXKfLKrcNy5w2QFQ8j8lM=";
  # vendorSha256 = lib.fakeHash;

  subPackages = ["cmd/imageproxy"];

  meta = with lib; {
    description = "a caching, resizing image proxy written in Go";
    license = licenses.asl20;
    homepage = "https://github.com/willnorris/imageproxy";
    maintainer = ["jason@mcneil.dev"];
  };
}
