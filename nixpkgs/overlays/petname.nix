self: super: {
    petname = super.stdenv.mkDerivation rec {
        name = "petname-${version}";
        version = "2.9";
        vendorHash = null;

        src = super.fetchFromGitHub {
            owner = "dustinkirkland";
            repo = "petname";
            rev = "${version}";
            sha256 = "sha256-AztCB4JnFHzJ/M8CWk9Vf7tDPL8B+Mu83GPELGstJ74=";
        };

        installPhase = ''
            sed -i "s#/usr/#$out/#g" $(find usr/ -type f)
            cp -R usr $out
        '';
    };
}
