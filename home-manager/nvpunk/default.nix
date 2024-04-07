{ stdenv, pkgs, fetchFromGithub }:

{
  nvpunk = stdenv.mkDerivation rec {
    pname = "nvpunk";
    version = "";
    dontBuild = true;

    src = pkgs.fetchFromGitLab {
      owner = "gabmus";
      repo = "nvpunk";
      rev = "4efdabbe06adf11770c5f40f78ff396865824dde";
      sha256 = "sha256-3VRkkBsf73bWzXFTNbjDaHhYIxuVfhnK4UvBZC8p2oM=";
    };

    installPhase = ''
      # Fetch the whole repo and put it in $out
      mkdir $out
      cp -aR $src/* $out/
    '';
  };

  # Move user config to ~/.config/nvpunk
  xdg.configFile."nvpunk/" = {
    source = ./nvpunk;
  };
}

