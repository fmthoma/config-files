{ config, pkgs, options, ... }: {
  config.virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    headless = false;
  };
}
