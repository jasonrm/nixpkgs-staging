{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "git-clean";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "mcasper";
    repo = pname;
    rev = "${version}";
    hash = "sha256-mhsmwvP2l3UVauLOqPHgGUo6rhuBNZsPah9oeX6oTxE=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-7ePRJFYjyzjR8TUL1yMMhqI3z76Rw+5cuX6NpyrdidY=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    description = "A Command Line Tool written in Rust for cleaning up local and remote Git branches";
    homepage = "https://github.com/mcasper/git-clean";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
