{ config, pkgs, options, ... }: {
  config.services = {
    actkbd = {
      enable = true;
      bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set 10%-"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set 10%+"; }
      ];
    };

    logind.settings.Login = {
      HandleLidSwitch = "lock";
      HandleLidSwitchDocked = "ignore";
    };

    tlp.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
    };
  };
  config.environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
