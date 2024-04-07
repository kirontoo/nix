{ pkgs, ... }: {
  home.packages = [
    pkgs.starship
  ];
  # Install the gitconfig file, as .gitconfig in the home directory
  # home.file.".gitconfig".source = ./gitconfig;
  xdg.configFile."starship.toml".source = ./starship.toml;
}
