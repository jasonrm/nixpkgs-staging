{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "godns";
  version = "V2.3.3";

  src = fetchFromGitHub {
    owner = "TimothyYe";
    repo = pname;
    rev = version;
    sha256 = "19r0qp7vgjy3b4pk4dj3ybn1c837i7gn3kh83mwq049cldvzz11s";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "07pn1srdwii51k05s43bn3qi487b1lsys111hhchx024d8318ja7";
  # vendorSha256 = lib.fakeSha256;

  # Checks are network based
  doCheck = false;

  meta = with lib; {
    description = "A dynamic DNS client tool supports AliDNS, Cloudflare, Google Domains, DNSPod, HE.net & DuckDNS & DreamHost, etc, written in Go.";
    license = licenses.asl20;
    homepage = "https://github.com/TimothyYe/godns";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
