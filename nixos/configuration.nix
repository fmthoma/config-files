# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

  networking.extraHosts = ''
    # Fixes Java UnknownHostException
    127.0.0.1 fthoma-nixos
  '' + (if builtins.pathExists /etc/nixos/hosts.local.nix then import /etc/nixos/hosts.local.nix else "");
  networking.firewall.allowedTCPPorts = [ 9100 ];
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "neo";

  time.timeZone = "Europe/Berlin";

  # Required for VBox Extensions
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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

  environment.variables = {
  };


  # List services that you want to enable:

  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  services.fwupd.enable = true;

  # Battery life
  services.tlp.enable = true;

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
    xkbVariant = "neo";
    libinput.enable = true;
    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
      autoLogin = {
        user = "thomaf";
        enable = true;
      };
      sessionCommands = ''
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

  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 15;
    percentageAction = 10;
  };

  services.resolved.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;

  services.prometheus.exporters.node.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.thomaf = {
    isNormalUser = true;
    group = "thomaf";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "dialout" "video" ];
    uid = 1000;
    createHome = true;
    shell = pkgs.zsh;
  };
  users.extraGroups.thomaf.gid = 1000;
  users.defaultUserShell = pkgs.zsh;
  programs.adb.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.gnupg.agent.enable = true;

  programs.light.enable = true;

  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   enableExtensionPack = true;
  #   headless = false;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
