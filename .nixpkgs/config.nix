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
        license = licenses.bsd3;
        platforms = platforms.linux;
        maintainers = [ maintainers.fmthoma ];
      };
    };
    otfcc = with pkgs; stdenv.mkDerivation rec {
      name = "otfcc-${version}";
      version = "0.6.3";

      src = fetchurl {
        url = "https://github.com/caryll/otfcc/archive/v${version}.tar.gz";
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
        license = licenses.asl20;
        platforms = platforms.linux;
        maintainers = [ maintainers.fmthoma ];
      };
    };
    iosevka = with pkgs; stdenv.mkDerivation rec {
      name = "iosevka-${version}";
      version = "1.12.5";

      width = "540"; # default: 500
      set = "custom";
      weight = "regular";

      src = fetchurl {
        url = "https://github.com/be5invis/Iosevka/archive/v${version}.tar.gz";
        sha256 = "1y5z4m62ss2819cabi8izdyh7d1rwlliyvr3vf05imxn129vd6pv";
      };

      nativeBuildInputs = [ unzip otfcc nodejs-6_x ttfautohint ];

      buildPhase = ''
        # Fake HOME directory for npm
        export HOME=$TMPDIR
        npm install
        make custom-config \
            set=${set} \
            upright=' \
                v-l-italic \
                v-i-italic \
                v-brace-straight \
                v-m-shortleg \
                v-zero-dotted \
                v-asterisk-low \
                v-caret-low \
                v-dollar-open \
            '
        sed -i 's/width = 500/width = ${width}/' parameters.toml
        make -f utility/custom.mk dist/iosevka-${set}/iosevka-${set}-${weight}.ttf set=${set} __IOSEVKA_CUSTOM_BUILD__=true
      '';

      installPhase = ''
        fontdir=$out/share/fonts/iosevka
        mkdir -p $fontdir
        cp -v dist/iosevka-custom/* $fontdir
      '';

      meta = with stdenv.lib; {
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
    };
  };
}
