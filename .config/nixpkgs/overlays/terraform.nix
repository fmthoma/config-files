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
        subPackages = [ "." ];
        src = super.fetchFromGitHub {
          inherit owner repo sha256;
          rev = "v${version}";
        };

        # Terraform allow checking the provider versions, but this breaks
        # if the versions are not provided via file paths.
        postBuild = "mv go/bin/${repo}{,_v${version}}";
      };

      plugin_aws_2_6 = tf_plugin {
        owner   = "terraform-providers";
        repo    = "terraform-provider-aws";
        version = "2.6.0";
        sha256 = "0hpnyid5w33n8ypwcz3a43gazbvk6m60b57qll2qgx6bm1q75b19";
      };

  in {

    terraform_0_11_13 = tf {
      version = "0.11.13";
      sha256 = "014d2ibmbp5yc1802ckdcpwqbm5v70xmjdyh5nadn02dfynaylna";
    };

    terraform_0_11_13-full = self.terraform_0_11_13.withPlugins (p: super.lib.attrValues p ++ [ plugin_aws_2_6 ]);

    terraform_0_11_11 = tf {
      version = "0.11.11";
      sha256 = "1hsi5sibs0fk1620wzzxrc1gqjs6slqrjvlqcgvgg1yl22q9g7f5";
    };

    terraform_0_11_11-full = self.terraform_0_11_11.withPlugins (p: super.lib.attrValues p);

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

    terraform_0_11 = self.terraform_0_11_11;

    terraform_0_11-full = self.terraform_0_11_11-full;

    terraform = self.terraform_0_11;

    terraform-full = self.terraform_0_11-full;
  }
