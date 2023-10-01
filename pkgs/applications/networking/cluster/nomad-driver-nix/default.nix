{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nomad-driver-nix";
  version = "git+010b09c68";

  src = fetchFromGitHub {
    owner = "input-output-hk";
    repo = pname;
    rev = "010b09c680887d0cade86e8ac136c3a04609e04a";
    hash = "sha256-hET+b7XhDLSuVQwXLI2V5nYCcdvxQQj9BAG8z4ta6CE=";
  };

  vendorHash = "sha256-FDJpbNtcFEHnZvWip2pvUHF3BFyfcSohrr/3nk9YS24=";

  subPackages = [ "." ];

  meta = with lib; {
    homepage = "https://github.com/input-output-hk/nomad-driver-nix";
    description = "Nix task driver for Nomad";
    license = licenses.mpl20;
  };
}