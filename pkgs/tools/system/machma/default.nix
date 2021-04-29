{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "machma";
  version = "9ab93d72e36fe2cbb15af37c914605212ac28642";

  src = fetchFromGitHub {
    owner = "fd0";
    repo = "machma";
    rev = version;
    hash = "sha256-VmyWAsWIe6dhLq7UEit389v3fnQqRwZYk5gY6gj6Q3M=";
    # hash = lib.fakeSha256;
  };

  vendorSha256 = "sha256-mu80QFccIHGqzHfj5zueO+P74p4irFfmU+cDgmn8URQ=";

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/fd0/machma";
    maintainer = ["jason@mcneil.dev"];
  };
}
