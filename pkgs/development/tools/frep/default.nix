{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "frep";
  version = "v1.3.13";

  src = fetchFromGitHub {
    owner = "subchen";
    repo = pname;
    rev = version;
    # hash = lib.fakeHash;
    hash = "sha256-opdUjCWVwnHhpFJ0BbjNsQjw5454B7ctK2nP23yBpcQ=";
  };

  # vendorHash = lib.fakeHash;
  vendorHash = "sha256-X2kkqEjWFpelBsPl9O0DMQwSz5myLs5pAnQL8QVeJ3s=";

  meta = with lib; {
    description = "Generate file using template from environment, arguments, json/yaml/toml config files";
    license = licenses.asl20;
    homepage = "https://github.com/subchen/frep";
    maintainer = ["jason@mcneil.dev"];
  };
}
