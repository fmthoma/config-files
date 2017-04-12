{
  allowUnfree = true;

  packageOverrides = pkgs: rec {
    premake5 = with pkgs; stdenv.mkDerivation {
      name = "premake-5.0.0-alpha11";

      src = fetchurl {
        url = "https://github.com/premake/premake-core/releases/download/v5.0.0-alpha11/premake-5.0.0-alpha11-src.zip";
        sha256 = "1mbcxbbfg6yp0nbvjbmx6vihxnygdwzvscj4chjbd1ac4af737wg";
      };

      buildInputs = [ unzip ];

      buildPhase = ''
        (cd build/gmake.unix/ && make config=release)
      '';

      installPhase = ''
        install -Dm755 bin/release/premake5 $out/bin/premake5
      '';

      meta = with stdenv.lib; {
        homepage = http://industriousone.com/premake;
        description = "A simple build configuration and project generation tool using lua";
        license = stdenv.lib.licenses.bsd3;
        platforms = platforms.linux;
        maintainers = [ maintainers.fmthoma ];
      };
    };
    otfcc = with pkgs; stdenv.mkDerivation {
      name = "otfcc";

      src = fetchurl {
        url = "https://github.com/caryll/otfcc/archive/v0.6.3.tar.gz";
        sha256 = "0zf0037k5njppyl1dj11ivj7i435p15kj9jcv2w9cdk5yj0i45jq";
      };

      buildInputs = [ unzip premake5 ];

      buildPhase = ''
        premake5 gmake
        (cd build/gmake && make config=release_x64)
      '';

      installPhase = ''
        install -Dm755 bin/Release-x64/otfccbuild $out/bin/otfccbuild
        install -Dm755 bin/Release-x64/otfccdump  $out/bin/otfccdump
      '';

      meta = with stdenv.lib; {
        homepage = "https://github.com/caryll/otfcc";
        description = "A library and utility used for parsing and writing OpenType font files";
        license = stdenv.lib.licenses.asl20;
        platforms = platforms.linux;
        maintainers = [ maintainers.fmthoma ];
      };
    };
  };
}
