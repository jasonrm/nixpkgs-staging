{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "cork";
  version = "41cf242";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = version;
    hash = "sha256-z7uZjWetGak2oY2PaWtO9aUss0IusDXq5Fy98eRBc0k=";
    # hash = lib.fakeHash;
  };

  # cargoHash = lib.fakeHash;
  cargoHash = "sha256-Yhcah/9Vt3NfyFS/88q/hjdipRFanOv1NIqxxQTQvdE=";

  meta = {
    homepage = "https://github.com/jasonrm/cork";
    maintainer = ["jason@mcneil.dev"];
  };
}
