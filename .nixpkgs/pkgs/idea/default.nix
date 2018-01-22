{stdenv, pkgs, fetchurl}:
pkgs.idea.idea-ultimate.overrideDerivation (super: rec {
  name = "idea-ultimate-${version}";
  version = "2017.3.3";
  src = fetchurl {
    url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
    sha256 = "0mbyb31kc9d52hnbn9dclbw0q9y0c6pi8351rbq68jphslm3i9q5";
  };
})
