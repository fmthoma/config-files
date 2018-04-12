self: super: {
  dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
    configurePhase = ''
      runHook preConfigure
      cp -v ${./config.solarized-dark.h} config.h
    '';
  });
}
