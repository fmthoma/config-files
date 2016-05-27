# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.trackpoint = {
    emulateWheel = true;
  };

  # Use the gummiboot efi boot loader.
  boot = {
    loader.gummiboot.enable = true;
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
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    firefox
    gitAndTools.gitFull
    htop
    meld
    neovim
    tig

    bc
    compton
    dmenu
    i3blocks
    i3status
    rxvt_unicode-with-plugins
    xdotool
    xorg.xwininfo

    cryptsetup
    wget
  ];

  nixpkgs.config.packageOverrides = pkgs : with pkgs; {
    i3 = i3.overrideDerivation (oldAttrs : rec {
      version = "4.12";
      name = "i3-gaps-4.12";
      src = fetchurl {
        url = "https://github.com/Airblader/i3/archive/4.12.tar.gz";
        sha256 = "1aad4c5e4da8a0f5895216393f728fb25e7d5959f97d113873054dc5464a34c5";
      };
      postUnpack = ''
          echo -n "4.12 (2016-03-06, branch \\\"gaps-next\\\")" > ./i3-4.12/I3_VERSION
          echo -n "4.12" > ./i3-4.12/VERSION
      '';
      postInstall = "";
    });
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "neo";
    windowManager = {
      i3.enable = true;
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.fthoma = {
    isNormalUser = true;
    group = "fthoma";
    extraGroups = [ "networkmanager" "wheel" ];
    uid = 1000;
    createHome = true;
    shell = "/run/current-system/sw/bin/zsh";
    password = "dummy";
  };
  users.extraGroups.fthoma.gid = 1000;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  programs.zsh.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
