self: super: {
  arduino-cli = self.stdenv.mkDerivation rec {
    version = "0.13.0";
    name = "arduino-cli-${version}";

    src = super.fetchurl {
      url = "https://downloads.arduino.cc/arduino-cli/arduino-cli_${version}_Linux_64bit.tar.gz";
      sha256 = "0r6ip0hq46isb2wsh13zwhm61shsk15fkb9c8bkvk66rdal3i2xq";
    };

    # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
    setSourceRoot = "sourceRoot=`pwd`";

    installPhase = ''
      mkdir -p $out/bin
      cp arduino-cli $out/bin/
    '';

    buildPhase = "";
  };
}
