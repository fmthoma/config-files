{ pkgs, lib, ... }: {
  home.stateVersion = "22.11";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    android-file-transfer
    arduino
    arduino-cli
    at-spi2-core # for `AT-SPI: Error retrieving accessibility bus address: org.freedesktop.DBus.Error.ServiceUnknown: The name org.a11y.Bus was not provided by any .service files` error messages in all GTK applications
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
    rofi
    rofi-bluetooth
    rofi-menugen
    rofi-pass
    rofi-pulse-select
    rofi-vpn
    signal-desktop
    stack
    stylish-haskell
    svgbob
    tig
    tldr
    tmux
    tree
    unzip
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
    status-notifier-watcher.enable = true; # required for taffybar
    taffybar.enable = true;
    xsettingsd.enable = true;
  };
  xdg.configFile."picom/picom.conf".text = lib.mkForce (lib.readFile ./picom.conf);

  gtk = {
    enable = true;
    theme.name = "Adwaita";
    iconTheme.name = "Papirus";
    iconTheme.package = pkgs.papirus-icon-theme;
    cursorTheme.name = "Adwaita";
    cursorTheme.package = pkgs.gnome.adwaita-icon-theme;
  };

  # Fixes https://github.com/nix-community/home-manager/pull/4316 (already on master, but not on release-22.11 yet)
  systemd.user.services.taffybar = {
    Unit = {
      StartLimitBurst = 5;
      StartLimitIntervalSec = 10;
    };
    Service.RestartSec = "2s";
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  xsession.preferStatusNotifierItems = true;
}
