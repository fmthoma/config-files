{ pkgs, lib, libtool, stdenv, fetchurl, fetchgit, unzip, nodejs, ttfautohint, python2, runCommand, writeTextFile, nix-gitignore }:

let

  # node-composition.nix, node-packages.nix and node-env.nix generated by node2nix (generate.sh)
  nodeDependencies = (import ./node-composition.nix {
    inherit nodejs pkgs;
    inherit (stdenv.hostPlatform) system;
  }).nodeDependencies.override(old: {
    dontNpmInstall = true;
  });

  version = "10.3.4";

  privateBuildPlans = ./private-build-plans.toml;

in

stdenv.mkDerivation {
  inherit version;

  name = "iosevka-${version}";

  src = fetchurl {
    url = "https://github.com/be5invis/Iosevka/archive/refs/tags/v${version}.zip";
    sha256 = "0kwmv3vagga9vymxfgz42gp5wpqy0naxx6llacpp63i1k43cy3s4";
  };

  nativeBuildInputs = [ unzip nodejs ttfautohint ];

  buildPhase = ''
    ln -s ${nodeDependencies}/lib/node_modules
    cp ${privateBuildPlans} ./private-build-plans.toml
    ls -la
    npm run build -- ttf::iosevka-custom
  '';

  installPhase = ''
    fontdir=$out/share/fonts/truetype
    mkdir -p $fontdir
    cp -v dist/iosevka-custom/ttf/* $fontdir
  '';

  meta = with lib; {
    homepage = "http://be5invis.github.io/Iosevka/";
    downloadPage = "https://github.com/be5invis/Iosevka/releases";
    description = ''
      Slender monospace sans-serif and slab-serif typeface inspired by Pragmata
      Pro, M+ and PF DIN Mono, designed to be the ideal font for programming.
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ maintainers.fmthoma ];
  };
}