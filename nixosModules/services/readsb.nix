{
  config,
  pkgs,
  lib,
}: with lib; let
  cfg = config.services.readsb;
in {
  options = {
    services.readsb = {
      enable = mkEnableOption "Enabled ADS-B decoder swiss knife";
    };
  };

  config = {
    systemd.services.readsb = mkIf cfg.enable {
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      serviceConfig = {
        ExecStart = "${pkgs.readsb}/bin/readsb";
        RestartSec = 600;
        Restart = "always";
      };
    };
  };
}
