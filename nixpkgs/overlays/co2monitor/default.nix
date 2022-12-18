self: super: {
  co2monitor = self.buildGoPackage rec {
    name = "co2monitor-unstable-${version}";
    version = "2018-03-05";
    rev = "e1da1402d985286ca57abd1685b469631dd7e3c9";

    goPackagePath = "github.com/larsp/co2monitor";

    src = super.fetchFromGitHub {
      owner = "larsp";
      repo = "co2monitor";
      inherit rev;
      sha256 = "0dbp26skk590zj52pga7gic10rkas4x6pn285visqw022bzmzx3l";
    };

    goDeps = ./deps.nix;
  };
}
