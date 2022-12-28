{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "up";
  version = "git-0630efc";

  src = fetchFromGitHub {
    owner = "alpn";
    repo = pname;
    rev = "0630efc81e651b182b92fd7de6afd58346b4c7f3";
    sha256 = "1b459rfqaxrps8kl0zw9hqh7qvhllg1f0bb7l07vvcnbmv62mmb6";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "1bc31yvylzgw96ig0c74ysbk0f8rwfg46mbx71prknq92xz8xpjf";
  # vendorSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "A simple utility for uploading stuff to BackBlaze's B2";
    license = licenses.mit;
    homepage = "https://github.com/alpn/up";
    maintainer = ["jason@mcneil.dev"];
  };
}
