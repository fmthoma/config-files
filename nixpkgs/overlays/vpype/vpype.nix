{ lib
, buildPythonPackage
, fetchPypi
, shapely
, asteval
, cachetools
, click
, multiprocess
, numpy
, pnoise
, scipy
, setuptools
, svgelements
, svgwrite
, tomli
, matplotlib
, glcontext
, moderngl
, pillow
, pyside2
, qt5
, hatched
, deduplicate
}:

buildPythonPackage rec {
  pname = "vpype";
  version = "1.9.0";

  # disabled = ; # requires python version >=3.7, !=2.7.*, !=3.0.*, !=3.1.*, !=3.2.*, !=3.3.*, !=3.4.*, !=3.5.*, !=3.6.*

  src = fetchPypi {
    inherit pname version;
    sha256 = "1b09fcd67ba911d8f558a09e3da6ae655ed921b7de599ebcacc7090550f77a71";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # Shapely[vectorized]==1.8.0
  # asteval>=0.9.26,<0.10.0
  # cachetools>=4.2.2
  # click>=8.0.1,<8.1.0
  # multiprocess>=0.70.11,<0.71.0
  # numpy>=1.20
  # pnoise>=0.1.0,<0.2.0
  # scipy>=1.6,<2.0
  # setuptools>=51.0.0,<52.0.0
  # svgelements==1.6.10
  # svgwrite>=1.4,<1.5
  # tomli>=2.0.0,<3.0.0
  # # Extra packages (may not be necessary)
  # matplotlib>=3.3.2,<3.6.0 # all
  # glcontext>=2.3.2 # all
  # moderngl>=5.6.2,<6.0.0 # all
  # Pillow>=9.0.0,!=9.0.1 # all
  # PySide2>=5.15.2,<6.0.0 # all
  # Sphinx>=4.0.1,<5.0.0 # docs
  # sphinx-click>=2.5.0 # docs
  # sphinx-autodoc-typehints>=1.12.0 # docs
  # sphinx-rtd-theme>=1.0.0 # docs
  # recommonmark>=0.6,<0.8 # docs

  patchPhase = ''
    sed -i "s/'setuptools.*'/'setuptools'/" setup.py
    sed -i "s/'toml.*'/'tomli'/" setup.py
    sed -i "s/'svgelements.*'/'svgelements'/" setup.py
    sed -i "s/'click.*'/'click'/" setup.py
    sed -i "s/'Shapely\[vectorized\].*'/'Shapely[Vectorized]'/" setup.py
  '';

  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  doCheck = false;

  nativeBuildInputs = [ qt5.wrapQtAppsHook ];

  propagatedBuildInputs = [
    shapely
    asteval
    cachetools
    click
    multiprocess
    numpy
    pnoise
    scipy
    setuptools
    svgelements
    svgwrite
    tomli
    matplotlib
    glcontext
    moderngl
    pillow
    pyside2
    hatched
    deduplicate
  ];
}
