self: super:
  let tf = { version, sha256 }: super.terraform_0_11.overrideAttrs (oldAttrs: rec {
        inherit version;
        name = "terraform-${version}";
        src = super.fetchFromGitHub {
          owner  = "hashicorp";
          repo   = "terraform";
          rev    = "v${version}";
          inherit sha256;
        };
      });

      tf_plugin = data: super.buildGoPackage rec {
        inherit (data) owner repo version sha256;
        name = "${repo}-${version}";
        goPackagePath = "github.com/${owner}/${repo}";
        src = super.fetchFromGitHub {
          inherit owner repo sha256;
          rev = "v${version}";
        };

        # Terraform allow checking the provider versions, but this breaks
        # if the versions are not provided via file paths.
        postBuild = "mv go/bin/${repo}{,_v${version}}";
      };

  in {

    terraform_0_11_8 = tf {
      version = "0.11.8";
      sha256 = "1kdmx21l32vj5kvkimkx0s5mxgmgkdwlgbin4f3iqjflzip0cddh";
    };

    terraform_0_11_8-full = self.terraform_0_11_8.withPlugins (p: super.lib.attrValues p);

    terraform_0_11_7 = tf {
      version = "0.11.7";
      sha256 = "0q5gl8yn1f8fas1v68lz081k88gbmlk7f2xqlwqmh01qpqjxd42q";
    };

    terraform_0_11_7-full = self.terraform_0_11_7.withPlugins (p: super.lib.attrValues p);

    terraform_0_11_5 = tf {
      version = "0.11.5";
      sha256 = "130ibb1pd60r2cycwpzs8qfwrz6knyc1a1849csxpipg5rs5q3jy";
    };

    terraform_0_11_5-full = self.terraform_0_11_5.withPlugins super.lib.attrValues;

    terraform_0_11 = self.terraform_0_11_5;

    terraform_0_11-full = self.terraform_0_11_5-full;

    terraform = self.terraform_0_11;

    terraform-full = self.terraform_0_11-full;
  }
