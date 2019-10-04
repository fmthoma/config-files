self: super: {
    petname-go = super.buildGoPackage rec {
        name = "petname-${version}";
        version = "2.10";

        owner = "dustinkirkland";
        repo = "golang-petname";
        goPackagePath = "github.com/${owner}/${repo}";

        src = super.fetchFromGitHub {
            inherit owner repo;
            rev = "1828ad0719e78226a086b9ffc4671bf96211174b";
            sha256 = "0gscqi8r7zbzpvjiwn2q0wpfskc913cxnnpmh5gp94x219jf8r3y";
        };
    };

    petname-python = super.pythonPackages.buildPythonPackage rec {
        pname = "petname";
        version = "2.6";

        src = super.pythonPackages.fetchPypi {
            inherit pname version;
            sha256 = "0k4y9jrxb68wgb37hid1xmch2bhhgk3bf6qdcirs6mi3fzpk274q";
        };
    };

    petname = super.stdenv.mkDerivation rec {
        name = "petname-${version}";
        version = "2.8";

        src = super.fetchFromGitHub {
            owner = "dustinkirkland";
            repo = "petname";
            rev = "da395d8e96eb39f0eac51a163b7329a7bc945c15";
            sha256 = "1lrwkm4g6sn7pcgpdn0md6kcnnzbksidp6wl70x4i4rdwb1y0g04";
        };

        installPhase = ''
            sed -i "s#/usr/#$out/#g" $(find usr/ -type f)
            cp -R usr $out
        '';
    };
}
