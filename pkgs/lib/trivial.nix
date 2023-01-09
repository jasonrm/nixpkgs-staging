{
  pkgs,
  lib,
  ...
}: {
  # Takes an attribute set and converts into shell scripts to act as "global aliases"
  # Ex.
  # aliasToPackage {
  #   str = "${gcc}/bin/strings $@";
  #   hms = "home-manager switch;
  # }
  aliasToPackage = alias:
    pkgs.symlinkJoin {
      name = "alias";
      paths = (
        lib.mapAttrsToList
        (name: value: pkgs.writeShellScriptBin name value)
        alias
      );
    };
}
