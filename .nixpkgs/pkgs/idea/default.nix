{stdenv, pkgs, fetchurl}:
pkgs.idea.idea-ultimate.overrideDerivation (super: rec {
  name = "idea-ultimate-${version}";
  version = "2017.1.2";
  src = fetchurl {
    url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
    sha256 = "01gfkb2xiqyg5g36y5crilyl5qqanwnvzi6jcg9rn0i5dzk0bqvz";
  };
})
