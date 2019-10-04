# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  hardware = {
    trackpoint.emulateWheel = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
  };

  # Use the gummiboot efi boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/nvme0n1p3";
        preLVM = true;
      }
    ];
  };

  networking.hostName = "fthoma-nixos"; # Define your hostname.
  networking.extraHosts = ''
    # Fixes Java UnknownHostException
    127.0.0.1 fthoma-nixos
  '' + import /etc/nixos/hosts.local.nix;
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };
  i18n.defaultLocale = "en_GB.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=/etc/nixos/overlays/" ];

  # pkgs does not respect overlays, so we have to include the desired ones manually
  # (see https://github.com/NixOS/nixpkgs/issues/24907).
  nixpkgs.overlays = [ (import "/etc/nixos/overlays/urxvt") ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    cachix

    firefox
    gitAndTools.gitFull
    gnupg
    htop
    meld
    msmtp
    mutt-with-sidebar
    ranger
    stack
    tig
    w3m

    bc
    compton
    dmenu
    dunst
    feh
    i3blocks
    i3lock
    i3status
    libnotify
    redshift
    rxvt_unicode
    xclip
    xdotool
    xorg.xbacklight
    xorg.xwininfo
    xss-lock

    cryptsetup
    networkmanagerapplet
    openvpn
    wget
    which
  ];

  environment.variables = {
  };


  # List services that you want to enable:

  # Battery life
  services.tlp.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  services.emacs.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip pkgs.epson-escpr pkgs.gutenprint ];
  };

  services.udev.extraRules = ''
    ACTION=="remove", GOTO="co2mini_end"
    SUBSYSTEMS=="usb", KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="a052", GROUP="plugdev", MODE="0666", SYMLINK+="co2mini%n", GOTO="co2mini_end"
    LABEL="co2mini_end"
  '';

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "neo";
    synaptics = {
      enable = true;
      additionalOptions = ''
        Option "TouchpadOff" "1"
      '';
    };
    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      default = "i3";
    };
    desktopManager = {
      default = "none";
    };
    displayManager = {
      auto = {
        user = "fthoma";
        enable = true;
      };
      sessionCommands = ''
        ${pkgs.xlibs.setxkbmap}/bin/setxkbmap de neo
        if test -e $HOME/.Xresources; then
          ${pkgs.xorg.xrdb}/bin/xrdb --merge $HOME/.Xresources
        fi
      '';
    };
  };

  services.logind.extraConfig = ''
    HandleLidSwitch=lock
    HandleLidSwitchDocked=ignore
  '';

  services.resolved.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.fthoma = {
    isNormalUser = true;
    group = "fthoma";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "dialout" ];
    uid = 1000;
    createHome = true;
    shell = "/run/current-system/sw/bin/zsh";
    password = "dummy";
  };
  users.extraGroups.fthoma.gid = 1000;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  programs.adb.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  nix.buildCores = 4;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host = {
    enable = true;
    headless = false;
  };
}
