{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "imageproxy";
  version = "v0.10.0";

  src = fetchFromGitHub {
    owner = "willnorris";
    repo = pname;
    rev = version;
    sha256 = "105dzzvzxblxm621ngqynh7bb475j1xrdvyi6namvqbykqb0zmih";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "02xmvfk9nfydwvzzhr040x17037mlgl4s7157ibp3nq0fgzw5bx0";
  # vendorSha256 = lib.fakeSha256;

  subPackages = ["cmd/imageproxy"];

  meta = with lib; {
    description = "a caching, resizing image proxy written in Go";
    license = licenses.asl20;
    homepage = "https://github.com/willnorris/imageproxy";
    # maintainers = with lib.maintainers; [ philandstuff rawkode ];
    # platforms = platforms.darwin ++ platforms.linux;
  };
}
