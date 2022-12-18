{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "svgelements";
  version = "1.6.11";

  src = fetchPypi {
    inherit pname version;
    sha256 = "73d4adb3d0eed05c7404015c45212aa0aa724e397ce487732819352bc38a603b";
  };

  doCheck = false;
}
