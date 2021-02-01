{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, darwin
}:
buildGoModule rec {
  pname = "pushnix";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "arnarg";
    repo = pname;
    rev = version;
    sha256 = "1p8v1mpad0lxb3nh4fg2wlyb78ky3745agjsawc4vy2hms41j246";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "1m2pqswhgizi3a3gk9c121ccwli05hh2ha76a9cmgy2gfy293dwh";
  # vendorSha256 = lib.fakeSha256;
  # vendorSha256 = null;

  # buildInputs = [
  # ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreFoundation ];

  meta = with lib; {
    description = "Simple cli utility that pushes NixOS configuration and triggers a rebuild using ssh.";
    # license = licenses.none;
    homepage = "https://github.com/arnarg/pushnix";
    maintainer = ["jason@mcneil.dev"];
  };
}
