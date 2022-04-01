{ lib
, buildPythonPackage
, fetchFromGitHub
, click
, tqdm
}:

buildPythonPackage rec {
  pname = "deduplicate";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "LoicGoulefert";
    repo = "deduplicate";
    rev = "2dfab09f2de5e2c2c891ab5cac00e3789889c29e";
    sha256 = "0jgrmnqcsr0l9i4kvv2kmzbqmgfx38g4x9h0qqpw8f2agm6082bm";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace '"vpype>=1.9, <2.0",' ""
    substituteInPlace setup.py \
      --replace '"tqdm==4.61.1",' '"tqdm",'
  '';

  doCheck = false;

  propagatedBuildInputs = [
    click
    tqdm
  ];
}
