{ config, pkgs, options, ... }: {
  config = {
    networking.hostName = "thomaf-t460s";

    # The NixOS release to be compatible with for stateful data such as databases.
    system.stateVersion = "16.03";

    nix.settings = {
      cores = 4;
      max-jobs = 4;
    };
  };
}
