{ config, pkgs, options, ... }: {
  config.services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "neo";
      };
      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };
      };
      displayManager = {
        lightdm.enable = true;
        sessionCommands = ''
          if test -e $HOME/.Xresources; then
            ${pkgs.xorg.xrdb}/bin/xrdb --merge $HOME/.Xresources
          fi
        '';
      };
    };
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        user = "thomaf";
        enable = true;
      };
    };
    libinput.enable = true;
  };
}
