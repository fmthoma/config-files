{ config, pkgs, options, ... }: {
  config.services = {
    keybase.enable = true;
    kbfs.enable = true;
  };
}
