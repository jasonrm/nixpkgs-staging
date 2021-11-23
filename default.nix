{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; }
, buildPecl ? pkgs.callPackage "${pkgs.path}/pkgs/build-support/build-pecl.nix" {
  stdenv = pkgs.stdenv;
  php = pkgs.php80.unwrapped;
}
}:
{
  lossless-cut = pkgs.callPackage ./pkgs/applications/video/lossless-cut { };
  godns = pkgs.callPackage ./pkgs/applications/networking/dyndns/godns { };
  ddns = pkgs.callPackage ./pkgs/applications/networking/dyndns/ddns { };
  trunk-recorder = pkgs.callPackage ./pkgs/applications/radio/trunk-recorder { };

  frep = pkgs.callPackage ./pkgs/development/tools/frep { };
  migrant = pkgs.callPackage ./pkgs/development/tools/migrant { };
  names = pkgs.callPackage ./pkgs/development/tools/names { };

  php-packages = {
    spx = pkgs.callPackage ./pkgs/development/php-packages/spx { inherit buildPecl; };
  };

  redis-cell = pkgs.callPackage ./pkgs/development/libraries/redis-cell { };

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
