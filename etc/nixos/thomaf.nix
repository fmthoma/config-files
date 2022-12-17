home-manager: { config, pkgs, options, ... }: {
  imports = [ home-manager.nixosModules.home-manager ];
  config.home-manager.users.thomaf = { pkgs, ... }: {
    home.stateVersion = "22.11";
    programs.firefox.enable = true;
  };
}
