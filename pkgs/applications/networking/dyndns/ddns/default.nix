{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "ddns";
  version = "v1.7.0";

  src = fetchFromGitHub {
    owner = "milgradesec";
    repo = pname;
    rev = version;
    sha256 = "1cdx22x8d8vncx7li6y4wynfx5j9d9kl9n0frbwvwrpzb7ly35lp";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "1hsj534859x1pz94917dfn5myyp81hjj08y67czf4agmk2n1g43s";
  # vendorSha256 = lib.fakeSha256;

  # Checks are network based
  # doCheck = false;

  meta = with lib; {
    description = "Dynamic DNS client for Cloudflare managed domains";
    license = licenses.asl20;
    homepage = "https://github.com/milgradesec/ddns";
    maintainer = ["jason@mcneil.dev"];
  };
}
