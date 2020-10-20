{ stdenv, otfcc, iosevka, nodejs }:

stdenv.mkDerivation rec {
  name = "imposevka-${iosevka.version}";

  src = ./imposevka-patcher;

  nativeBuildInputs = [ otfcc nodejs ];

  buildPhase = ''
    mkdir src
    mkdir dst
    mkdir tmp

    cp -v ${iosevka}/share/fonts/truetype/iosevka-* src/
    make
  '';

  installPhase = ''
    fontdir=$out/share/fonts/truetype
    mkdir -p $fontdir
    cp -v dst/* $fontdir
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    description = ''
      NerdFont patched Iosevka
    '';
    platforms = platforms.all;
    maintainers = [ maintainers.fmthoma ];
  };
}
