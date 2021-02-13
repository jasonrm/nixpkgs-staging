{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "frep";
  version = "v1.3.12";

  src = fetchFromGitHub {
    owner = "subchen";
    repo = pname;
    rev = version;
    sha256 = "0458jwghkg1lv4pxmaj4ifkkmvlpg5y82xxj8n1gyi5p4yhrh0kv";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "0yr7bq2z22vl09lwwbmjk77i431i0gnz9rf30sjrf5nn92l28saz";
  # vendorSha256 = lib.fakeSha256;

  # subPackages = ["cmd/imageproxy"];

  meta = with lib; {
    description = "Generate file using template from environment, arguments, json/yaml/toml config files";
    license = licenses.asl20;
    homepage = "https://github.com/subchen/frep";
    maintainer = ["jason@mcneil.dev"];
  };
}
