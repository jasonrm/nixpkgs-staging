{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "transmission-rss-go";
  version = "fc49bb36";

  src = fetchFromGitHub {
    owner = "whatust";
    repo = pname;
    rev = "fc49bb365b9a0f321ceb08aa5c21892497750d01";
    hash = "sha256-PnfqeMzu7bkGT1wj8DslsxBk9sIZ7JQz+8nl8bn6jEw=";
    # hash = lib.fakeHash;
  };

  vendorSha256 = "sha256-qxgylezVgc3v9pmm9gswhK3xNtN/pj01ttgiFgtq1mA=";
  # vendorSha256 = lib.fakeHash;

  # Checks are network based
  # doCheck = false;

  meta = with lib; {
    description = "Dynamic DNS client for Cloudflare managed domains";
    license = licenses.gpl3;
    homepage = "https://github.com/whatust/transmission-rss-go";
    maintainer = ["jason@mcneil.dev"];
  };
}
