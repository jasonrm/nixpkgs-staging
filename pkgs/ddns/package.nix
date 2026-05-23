{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ddns";
  version = "2.0.6";

  src = fetchFromGitHub {
    owner = "milgradesec";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-c4uidQViwvVzOFWqdKtOmquVQ7XIDGfmS+KYhLuKRLU=";
  };

  vendorHash = "sha256-uYbtEAlsy6HC5jGj0xw9os+tWK6/oXBtJutlBtoQ08M=";

  # Checks are network based
  # doCheck = false;

  meta = with lib; {
    description = "Dynamic DNS client for Cloudflare managed domains";
    license = licenses.asl20;
    homepage = "https://github.com/milgradesec/ddns";
    maintainer = ["jason@mcneil.dev"];
  };
}
