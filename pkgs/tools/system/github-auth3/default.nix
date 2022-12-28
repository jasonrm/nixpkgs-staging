{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  darwin,
}:
buildGoModule rec {
  pname = "github-auth3";
  version = "feature-teams";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = version;
    sha256 = "0i3z3a28ml9rp4lcbizi9mp5msfy07gy84pslp147n8ysbpvkf8h";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "19cxs3z4blr148xjjfysl1mv13dzgdg31jvxadfz0789cwlyv2ip";
  # vendorSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "Use Github for your SSH AuthorizedKeysCommand";
    # license = licenses.mit;
    homepage = "https://github.com/tsutsu/github-auth3";
    maintainer = ["jason@mcneil.dev"];
  };
}
