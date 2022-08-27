{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; }
}:
let
  phpExtensions = {
    packageOverrides = final: prev: {
      extensions = prev.extensions // {
        spx = pkgs.callPackage ./pkgs/development/php-packages/spx { inherit (prev) buildPecl; };
      };
    };
  };
in
rec {
  lossless-cut = pkgs.callPackage ./pkgs/applications/video/lossless-cut { };
  godns = pkgs.callPackage ./pkgs/applications/networking/dyndns/godns { };
  ddns = pkgs.callPackage ./pkgs/applications/networking/dyndns/ddns { };
  trunk-recorder = pkgs.callPackage ./pkgs/applications/radio/trunk-recorder { };
  glscopeclient = pkgs.callPackage ./pkgs/applications/science/electronics/glscopeclient {
    inherit ffts;
  };

  frep = pkgs.callPackage ./pkgs/development/tools/frep { };
  migrant = pkgs.callPackage ./pkgs/development/tools/migrant { };
  names = pkgs.callPackage ./pkgs/development/tools/names { };

  # TODO: Is there a better alternative to this?
  php = pkgs.php.override phpExtensions;
  php74 = pkgs.php74.override phpExtensions;
  php80 = pkgs.php80.override phpExtensions;
  php81 = pkgs.php81.override phpExtensions;

  redis-cell = pkgs.callPackage ./pkgs/development/libraries/redis-cell { };
  ffts = pkgs.callPackage ./pkgs/development/libraries/ffts { };

  bupstash = pkgs.callPackage ./pkgs/tools/backup/bupstash { };
  imaptar = pkgs.callPackage ./pkgs/tools/backup/imaptar { };
  imapbox = pkgs.callPackage ./pkgs/tools/backup/imapbox { };
  up = pkgs.callPackage ./pkgs/tools/backup/up { };

  manticoresearch = pkgs.callPackage ./pkgs/servers/search/manticoresearch { };
  imageproxy = pkgs.callPackage ./pkgs/servers/imageproxy { };
  slowlogfmt = pkgs.callPackage ./pkgs/servers/monitoring/slowlogfmt { };
  etherdfs = pkgs.callPackage ./pkgs/servers/etherdfs { };

  go-httpbin = pkgs.callPackage ./pkgs/tools/networking/go-httpbin { };

  github-auth3 = pkgs.callPackage ./pkgs/tools/system/github-auth3 { };
  pushnix = pkgs.callPackage ./pkgs/tools/system/pushnix { };
  ssh-permit-a38 = pkgs.callPackage ./pkgs/tools/system/ssh-permit-a38 { };
  supervisord-go = pkgs.callPackage ./pkgs/tools/system/supervisord-go { };
  uritool = pkgs.callPackage ./pkgs/tools/system/uritool { };
  intelmas = pkgs.callPackage ./pkgs/tools/system/intelmas { };
  rnd64 = pkgs.callPackage ./pkgs/tools/system/rnd64 { };
  machma = pkgs.callPackage ./pkgs/tools/system/machma { };
  vlmcsd = pkgs.callPackage ./pkgs/tools/system/vlmcsd { };

  mdbook-nix-eval = pkgs.callPackage ./pkgs/tools/text/mdbook-nix-eval { };
}
