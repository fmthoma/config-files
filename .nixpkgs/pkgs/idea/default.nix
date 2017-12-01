{stdenv, pkgs, fetchurl}:
pkgs.idea.idea-ultimate.overrideDerivation (super: rec {
  name = "idea-ultimate-${version}";
  version = "2017.3";
  src = fetchurl {
    url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
    sha256 = "09fk0x789llanm34xxsb8j4y5nmllvjs2rzqbcc5y4ad06sb4pgp";
  };
})
