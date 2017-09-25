{stdenv, pkgs, fetchurl}:
pkgs.idea.idea-ultimate.overrideDerivation (super: rec {
  name = "idea-ultimate-${version}";
  version = "2017.2.5";
  src = fetchurl {
    url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
    sha256 = "0b3d8ch4snrfhxpnrns4nmk0b9s3drlhjbg98a6h1s6jzanz13x0";
  };
})
