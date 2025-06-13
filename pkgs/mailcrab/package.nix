{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "mailcrab";
  version = "v1.6.1";

  src = fetchFromGitHub {
    owner = "tweedegolf";
    repo = pname;
    rev = version;
    hash = "sha256-w0RMvhLT662vVspdfpxzJfjvh/X74KoM2Lw4XKwD8yo=";
    # hash = lib.fakeHash;
  };

  sourceRoot = "${src.name}/mailcrab";

  cargoHash = "sha256-RBiMeYojIMJZuJnebgQKrubBiPgAV57l2XJ0XXnNDe4=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Email test server for development, written in Rust.";
    homepage = "https://github.com/tweedegolf/mailcrab";
    license = licenses.asl20;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
