{ pkgs ? import <nixpkgs> { } }:
{
  lossless-cut = pkgs.callPackage ./pkgs/applications/video/lossless-cut { };

  migrant = pkgs.callPackage ./pkgs/development/tools/migrant { };

  redis-cell = pkgs.callPackage ./pkgs/development/libraries/redis-cell { };

  bupstash = pkgs.callPackage ./pkgs/tools/backup/bupstash { };
  imaptar = pkgs.callPackage ./pkgs/tools/backup/imaptar { };
  imapbox = pkgs.callPackage ./pkgs/tools/backup/imapbox { };
  up = pkgs.callPackage ./pkgs/tools/backup/up { };

  manticoresearch = pkgs.callPackage ./pkgs/servers/search/manticoresearch { };
  imageproxy = pkgs.callPackage ./pkgs/servers/imageproxy { };

  ssh-permit-a38 = pkgs.callPackage ./pkgs/tools/system/ssh-permit-a38 { };
  supervisord-go = pkgs.callPackage ./pkgs/tools/system/supervisord-go { };
  uritool = pkgs.callPackage ./pkgs/tools/system/uritool { };
}
