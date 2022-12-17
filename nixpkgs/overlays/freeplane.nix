self: super: {
  freeplane = self.stdenv.mkDerivation rec {
    version = "1.8.6";
    name = "freeplane-${version}";

    src = self.fetchurl {
      url = "https://sourceforge.net/projects/freeplane/files/freeplane%20stable/freeplane_bin-${version}.zip/download";
      sha512 = "185d69rhyw4i6k2chidsqgbif9qikk39li4fvw68aad3fl60p0blr48l5hgrkcfp39nkxkp188g76srnqi19kgrj1had1g57ad16jcl";
    };

    nativeBuildInputs = [
      self.unzip self.makeWrapper
    ];

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp -r freeplane-${version}/* $out/share
      makeWrapper $out/share/freeplane.sh $out/bin/freeplane --set JAVA_HOME ${self.jre}
    '';

    meta = with self.lib; {
      description = "Mind-mapping software";
      homepage = https://www.freeplane.org/wiki/index.php/Home;
      license = licenses.gpl2Plus;
      platforms = platforms.linux;
    };
  };
}
