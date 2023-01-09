{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.silverbullet;
in {
  options = with lib.types; {
    services.silverbullet = {
      enable = mkEnableOption "Enabled Silver Bullet, an extensible, open source personal knowledge platform";
      folder = mkOption {
        type = str;
      };
    };
  };

  config = {
    systemd.services.silverbullet = mkIf cfg.enable {
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      serviceConfig = {
        ExecStart = "${pkgs.silverbullet}/bin/silverbullet ${cfg.folder}";
        RestartSec = 600;
        Restart = "always";
      };
    };
  };
}
