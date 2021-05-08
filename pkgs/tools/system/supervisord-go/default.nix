{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "supervisord-go";
  version = "d73619e2562b5e2f719541e278148b68fa98f3c6";

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = version;
    sha256 = "0xkpigdk2iplagfjavm6sa4rzmhsa3h2gscjd29vvky7wmig3ykp";
    # sha256 = lib.fakeSha256;
  };

  vendorSha256 = "1han6mm61r0lksbyb81yrfp0pnsf5rw6lj9h6y6hxd5blqinskq5";
  # vendorSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
