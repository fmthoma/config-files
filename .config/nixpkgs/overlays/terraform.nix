self: super: {

  terraform_0_11_5 = super.terraform_0_11.overrideAttrs (oldAttrs: rec {
    name = "terraform-${version}";
    version = "0.11.5";
    src = super.fetchFromGitHub {
      owner  = "hashicorp";
      repo   = "terraform";
      rev    = "v${version}";
      sha256 = "130ibb1pd60r2cycwpzs8qfwrz6knyc1a1849csxpipg5rs5q3jy";
    };
  });

  terraform_0_11_5-full = self.terraform_0_11.withPlugins super.lib.attrValues;

  terraform_0_11 = self.terraform_0_11_5;

  terraform_0_11-full = self.terraform_0_11_5-full;

  terraform = self.terraform_0_11;

  terraform-full = self.terraform_0_11-full;
}
