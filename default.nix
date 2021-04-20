{ pkgs ? import <nixpkgs> { } }:
{
  lossless-cut = pkgs.callPackage ./pkgs/applications/video/lossless-cut { };
  godns = pkgs.callPackage ./pkgs/applications/networking/dyndns/godns { };
  ddns = pkgs.callPackage ./pkgs/applications/networking/dyndns/ddns { };

  frep = pkgs.callPackage ./pkgs/development/tools/frep { };
  migrant = pkgs.callPackage ./pkgs/development/tools/migrant { };

  redis-cell = pkgs.callPackage ./pkgs/development/libraries/redis-cell { };

  bupstash = pkgs.callPackage ./pkgs/tools/backup/bupstash { };
  imaptar = pkgs.callPackage ./pkgs/tools/backup/imaptar { };
  imapbox = pkgs.callPackage ./pkgs/tools/backup/imapbox { };
  up = pkgs.callPackage ./pkgs/tools/backup/up { };

  manticoresearch = pkgs.callPackage ./pkgs/servers/search/manticoresearch { };
  imageproxy = pkgs.callPackage ./pkgs/servers/imageproxy { };
  slowlogfmt = pkgs.callPackage ./pkgs/servers/monitoring/slowlogfmt { };

  github-auth3 = pkgs.callPackage ./pkgs/tools/system/github-auth3 { };
  pushnix = pkgs.callPackage ./pkgs/tools/system/pushnix { };
  ssh-permit-a38 = pkgs.callPackage ./pkgs/tools/system/ssh-permit-a38 { };
  supervisord-go = pkgs.callPackage ./pkgs/tools/system/supervisord-go { };
  uritool = pkgs.callPackage ./pkgs/tools/system/uritool { };
  intelmas = pkgs.callPackage ./pkgs/tools/system/intelmas { };

  mdbook-nix-eval = pkgs.callPackage ./pkgs/tools/text/mdbook-nix-eval { };
}
