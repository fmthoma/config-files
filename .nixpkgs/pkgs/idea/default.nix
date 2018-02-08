{stdenv, pkgs, fetchurl}:
pkgs.idea.idea-ultimate.overrideDerivation (super: rec {
  name = "idea-ultimate-${version}";
  version = "2017.3.4";
  src = fetchurl {
    url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
    sha256 = "1g5zaz6aak1qk31ia601fhrmqda4z4lx76wac7h08z1izab3gwyi";
  };
})
