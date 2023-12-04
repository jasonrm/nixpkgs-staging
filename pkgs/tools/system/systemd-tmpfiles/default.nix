{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-tmpfiles";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-q6IYS8j92VVLsspMILVercOSWrDDemOa/MjR9lzUABg=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-SMDrrVvm9yUQZkZZyvTYWuZyR64B8ZGTkq3+vQPqiDc=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "A limited and simple implementation of systemd-tmpfiles in Rust";
    homepage = "https://github.com/jasonrm/systemd-tmpfiles";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
