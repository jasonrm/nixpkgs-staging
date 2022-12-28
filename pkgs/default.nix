{pkgs, ...}: let
  phpExtensions = {
    packageOverrides = final: prev: {
      extensions =
        prev.extensions
        // {
          spx = pkgs.callPackage ./development/php-packages/spx {inherit (prev) buildPecl;};
        };
    };
  };
in rec {
  lossless-cut = pkgs.callPackage ./applications/video/lossless-cut {};
  godns = pkgs.callPackage ./applications/networking/dyndns/godns {};
  ddns = pkgs.callPackage ./applications/networking/dyndns/ddns {};
  transmission-rss-go = pkgs.callPackage ./applications/networking/p2p/transmission-rss-go {};
  trunk-recorder = pkgs.callPackage ./applications/radio/trunk-recorder {};
  readsb = pkgs.callPackage ./applications/radio/readsb {};
  glscopeclient = pkgs.callPackage ./applications/science/electronics/glscopeclient {
    inherit ffts;
  };

  frep = pkgs.callPackage ./development/tools/frep {};
  migrant = pkgs.callPackage ./development/tools/migrant {};
  names = pkgs.callPackage ./development/tools/names {};

  # TODO: Is there a better alternative to this?
  php = pkgs.php.override phpExtensions;
  php80 = pkgs.php80.override phpExtensions;
  php81 = pkgs.php81.override phpExtensions;

  redis-cell = pkgs.callPackage ./development/libraries/redis-cell {};
  ffts = pkgs.callPackage ./development/libraries/ffts {};

  bupstash = pkgs.callPackage ./tools/backup/bupstash {};
  imaptar = pkgs.callPackage ./tools/backup/imaptar {};
  imapbox = pkgs.callPackage ./tools/backup/imapbox {};
  up = pkgs.callPackage ./tools/backup/up {};

  manticoresearch = pkgs.callPackage ./servers/search/manticoresearch {};
  imageproxy = pkgs.callPackage ./servers/imageproxy {};
  slowlogfmt = pkgs.callPackage ./servers/monitoring/slowlogfmt {};
  etherdfs = pkgs.callPackage ./servers/etherdfs {};
  radius-mac = pkgs.callPackage ./servers/radius-mac {};

  go-httpbin = pkgs.callPackage ./tools/networking/go-httpbin {};

  github-auth3 = pkgs.callPackage ./tools/system/github-auth3 {};
  pushnix = pkgs.callPackage ./tools/system/pushnix {};
  ssh-permit-a38 = pkgs.callPackage ./tools/system/ssh-permit-a38 {};
  supervisord-go = pkgs.callPackage ./tools/system/supervisord-go {};
  uritool = pkgs.callPackage ./tools/system/uritool {};
  intelmas = pkgs.callPackage ./tools/system/intelmas {};
  rnd64 = pkgs.callPackage ./tools/system/rnd64 {};
  machma = pkgs.callPackage ./tools/system/machma {};
  vlmcsd = pkgs.callPackage ./tools/system/vlmcsd {};
  tere = pkgs.callPackage ./tools/system/tere {};

  mdbook-nix-eval = pkgs.callPackage ./tools/text/mdbook-nix-eval {};
}
