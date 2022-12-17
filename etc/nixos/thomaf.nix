home-manager: { config, pkgs, options, ... }: {
  imports = [ home-manager.nixosModules.home-manager ];
  config.home-manager.users.thomaf = { pkgs, ... }: {
    home.stateVersion = "22.11";

    nixpkgs.config = {
      allowUnfree = true;
    };

    home.packages = with pkgs; [
      bc
      compton
      dmenu
      dunst
      fasd
      feh
      i3blocks
      i3lock
      i3status
      meld
      msmtp
      mutt-with-sidebar
      networkmanagerapplet
      ranger
      stack
      tig
      vscode
      w3m
      xclip
      xdotool
    ];

    programs = {
        firefox.enable = true;
    };
  };
}
