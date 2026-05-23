{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "imageproxy";
  version = "v0.13.0";

  src = fetchFromGitHub {
    owner = "willnorris";
    repo = pname;
    rev = version;
    hash = "sha256-nB4Fip+eygIVkpCx4Cuewwn63tuL1SEFr164+VmmW1s=";
  };

  vendorHash = "sha256-/XIlWcrPqkRHiT9KsszZw7lsL1+kAaH1lopioNKu260=";

  subPackages = ["cmd/imageproxy"];

  meta = with lib; {
    description = "a caching, resizing image proxy written in Go";
    license = licenses.asl20;
    homepage = "https://github.com/willnorris/imageproxy";
    maintainer = ["jason@mcneil.dev"];
  };
}
