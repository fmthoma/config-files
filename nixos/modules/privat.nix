{ config, pkgs, options, ... }: {
  config.users = {
    extraUsers.privat = {
      isNormalUser = true;
      group = "privat";
      extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "dialout" "video" ];
      uid = 1001;  
      createHome = true;
      shell = pkgs.zsh;
    };
    extraGroups.privat.gid = 1001;
  };
  config.nix.settings.trusted-users = [ "privat" ];
}
