{ lib
, buildPythonPackage
, fetchFromGitHub
, svgwrite
, shapely
, numpy
, matplotlib
, opencv3
, black
, isort
, click
, scikitimage
}:

buildPythonPackage rec {
  pname = "hatched";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "plottertools";
    repo = "hatched";
    rev = "b6190b7463a9497ec21ccd603b7aab3ba2d5440f";
    sha256 = "0xknfpmnkhlnagwm85vfih96zjj2l24id4zq4sj2p58mnr4xir7m";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace '"opencv-python",' ""
    substituteInPlace setup.py \
      --replace '"vpype>=1.9,<2.0",' ""
  '';

  doCheck = false;

  propagatedBuildInputs = [
    svgwrite
    shapely
    numpy
    matplotlib
    opencv3
    black
    isort
    click
    scikitimage
  ];
}
