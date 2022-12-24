{ config, pkgs, options, ... }: {
  config.users = {
    extraUsers.thomaf = {
      isNormalUser = true;
      group = "thomaf";
      extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "dialout" "video" ];
      uid = 1000;
      createHome = true;
      shell = pkgs.zsh;
    };
    extraGroups.thomaf.gid = 1000;
  };
}
