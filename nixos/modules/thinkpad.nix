{ config, pkgs, options, ... }: {
  config.services = {
    actkbd = {
      enable = true;
      bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      ];
    };

    logind.extraConfig = ''
      HandleLidSwitch=lock
      HandleLidSwitchDocked=ignore
    '';

    tlp.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
    };
  };

  config.programs = {
    light.enable = true;
  };
}
