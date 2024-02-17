{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  darwin,
}:
buildGoModule rec {
  pname = "spotinfo";
  version = "1.0.7+git";

  src = fetchFromGitHub {
    owner = "alexei-led";
    repo = pname;
    rev = "45983c0daec6055952ccfd77be87ccdd5d024de7";
    hash = "sha256-DZ62TMYbvVUZ4MmY0R5VXXPTl14l+SvdRwFccNApF+A=";
    # hash = lib.fakeHash;
  };

  vendorHash = "sha256-tJnrERNHtFzwVJ+MxOJiZmoHOLnUnj5QN3ACY5Yp/hU=";
  # vendorHash = lib.fakeHash;

  meta = with lib; {
    description = "CLI for exploring AWS EC2 Spot inventory. Inspect AWS Spot instance types, saving, price, and interruption frequency.";
    license = licenses.asl20;
    homepage = "https://github.com/alexei-led/spotinfo";
    maintainer = ["jason@mcneil.dev"];
  };
}
