{ lib
, buildPythonPackage
, fetchPypi
, numpy
, setuptools
}:

buildPythonPackage rec {
  pname = "pnoise";
  version = "0.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "ad51bc5e48cf86785d446b14e6ce088eb2c0e96555a3cdc39dc5140b25a88bd3";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # numpy (>=1.19)
  propagatedBuildInputs = [
    numpy
    setuptools
  ];
}
