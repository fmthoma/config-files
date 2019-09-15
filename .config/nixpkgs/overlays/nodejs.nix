self: super: {
    nodejs-8_x = super.nodejs.overrideAttrs (oldAttrs: rec {
        version = "8.16.1";
        name = "nodejs-${version}";
        src = self.fetchurl {
            url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
            sha256 = "04h5ddshz2id7jp2v1b7klj4x38ssf1zhbf296ppz5idvyn91hfq";
        };
    });
    yarn-8_x = super.yarn.override { nodejs = self.nodejs-8_x; };
}