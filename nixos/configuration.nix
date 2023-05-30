{ config, pkgs, options, ... }: {

  hardware = {
    trackpoint.emulateWheel = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    plymouth.theme = "breeze";
    initrd.systemd.enable = true;
  };

  networking = {
    extraHosts = ''
      # Fixes Java UnknownHostException
      127.0.0.1 fthoma-nixos
    '' + (if builtins.pathExists /etc/nixos/hosts.local.nix then import /etc/nixos/hosts.local.nix else "");
    firewall.allowedTCPPorts = [ 9100 ];
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "neo";

  time.timeZone = "Europe/Berlin";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    gnupg
    htop

    libnotify
    rxvt-unicode-emoji
    xorg.xwininfo
    xss-lock

    cryptsetup
    openvpn
    wget
    which
    moreutils
    pciutils
  ];

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    blueman.enable = true;

    fwupd.enable = true;

    openssh = {
      enable = true;
      passwordAuthentication = false;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.hplip pkgs.epson-escpr pkgs.gutenprint ];
    };

    prometheus.exporters.node.enable = true;

    resolved.enable = true;

    udisks2.enable = true;
  };

  programs = {
    adb.enable = true;

    gnupg.agent.enable = true;

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
