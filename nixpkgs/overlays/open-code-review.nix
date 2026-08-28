self: super: {
  open-code-review = let
    version = "1.11.0";
    ocrBin = super.fetchurl {
      url = "https://github.com/alibaba/open-code-review/releases/download/v${version}/opencodereview-linux-amd64";
      sha256 = "13f68cc2eca1a36d42140e9d37797b68fea5cbbf4b6345ec01ec1b06910fab60";
    };
  in super.stdenv.mkDerivation {
    pname = "open-code-review";
    inherit version;
    src = super.fetchurl {
      url = "https://registry.npmjs.org/@alibaba-group/open-code-review/-/open-code-review-${version}.tgz";
      hash = "sha512-3BBp49PSRMjk0YJcRSM2E2wINfYBO5WUI9SShx4K2ZRchUlae89oMDo7+kNCYC7eySvOPXTV7KR3vp70NehrRQ==";
    };
    nativeBuildInputs = [ super.makeWrapper ];
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      pkgDir=$out/lib/node_modules/@alibaba-group/open-code-review
      mkdir -p "$pkgDir"
      cp -R . "$pkgDir/"
      install -Dm555 ${ocrBin} "$pkgDir/bin/opencodereview"
      mkdir -p "$out/bin"
      makeWrapper ${super.nodejs}/bin/node "$out/bin/ocr" \
        --add-flags "$pkgDir/bin/ocr.js"
      runHook postInstall
    '';
    meta = with super.lib; {
      description = "OpenCodeReview CLI — AI-powered code review tool";
      homepage = "https://github.com/alibaba/open-code-review";
      license = licenses.asl20;
      mainProgram = "ocr";
    };
  };
}
