{ pkgs, lib, ... }: {
  home.stateVersion = "22.11";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    android-file-transfer
    arduino
    arduino-cli
    bc
    binutils
    chromium
    cloc
    co2monitor
    delta
    dmenu
    evince
    evolution
    fasd
    feh
    freeplane
    ghcid
    gnome.nautilus
    google-chrome
    gucharmap
    release-22_11.haskellPackages.vgrep
    i3blocks
    i3lock
    i3status
    imagemagick
    imposevka
    inkscape
    iosevka
    jq
    keymap-visualizer
    libreoffice
    lsd
    meld
    msmtp
    mutt-with-sidebar
    nload
    pandoc
    parallel
    pass
    pavucontrol
    petname
    powertop
    ranger
    restic
    signal-desktop
    stack
    stylish-haskell
    svgbob
    tig
    tldr
    tmux
    tree
    unzip
    v4l-utils
    vim
    vistafonts
    vscode
    w3m
    xclip
    xdotool
    xkcdpass
    xsel
    yq
    zoom-us
  ];

  programs = {
      firefox.enable = true;
      browserpass.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      configFile = ./dunstrc;
    };
    gammastep = {
      enable = true;
      latitude = 48.1;
      longitude = 11.6;
      tray = true;
    };
    picom.enable = true;
    poweralertd.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    pasystray.enable = true;
    syncthing.enable = true;
  };
  xdg.configFile."picom/picom.conf".text = lib.mkForce (lib.readFile ./picom.conf);
}
