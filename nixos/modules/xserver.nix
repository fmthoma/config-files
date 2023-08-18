{ config, pkgs, options, ... }: {
  config.services.xserver = {
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
}
