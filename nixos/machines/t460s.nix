{ config, pkgs, options, lib, ... }: {
  config = {
    networking.hostName = "thomaf-t460s";

    # The NixOS release to be compatible with for stateful data such as databases.
    system.stateVersion = "16.03";

    # Really old battery
    services.upower = lib.mkForce {
      percentageLow = 50;
      percentageCritical = 40;
      percentageAction = 30;
    };
  };
}
