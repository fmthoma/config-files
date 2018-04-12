{stdenv, pkgs}:

pkgs.dmenu.overrideDerivation (super: rec {
  configurePhase = ''
    runHook preConfigure
    cp -v ${./config.solarized-dark.h} config.h
  '';
})
