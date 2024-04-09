{ config, pkgs, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/alacritty.nix
    ./apps/neovim.nix
    ./starship/default.nix
    ./zsh/zsh.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # https://github.com/nix-community/home-manager/issues/1439#issuecomment-1605851533
  # for home-manager installed apps to show up in system
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  # install nvpunk config files
  # https://nvpunk.gabmus.org/
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ./nvpunk/default.nix{}).nvpunk;
    recursive = true;
  };

  # Move user config to ~/.config/nvpunk
  xdg.configFile."nvpunk/" = {
    source = ./nvpunk/nvpunk;
    recursive = true;
  };

  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = "/usr/bin/sudo /usr/bin/chmod -R 777 $HOME/.nix-profile/share/applications && /usr/bin/update-desktop-database $HOME/.nix-profile/share/applications";
    };
  };

  home.username = "daedalus";
  home.homeDirectory = "/home/daedalus";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    neofetch
    obsidian
    vim
    discord
    spotify
    thunderbird
    ripgrep

    ## cli apps
    tomato-c

    nerdfonts
   (nerdfonts.override { fonts = [ 
     "FiraCode" 
     "SpaceMono" 
     "3270" 
     "CascadiaCode" 
     "FantasqueSansMono" 
     "ShareTechMono" 
     "SourceCodePro"
     "NerdFontsSymbolsOnly"
     "Terminus"
     "UbuntuMono"
     "VictorMono"
   ]; })

    libgcc

    # system utilities
    htop
    gotop

    # useful shell utils
    fd
    jq
    wget
    less
    tree

    # dev tools
    go
    python3

    # Javascript Development Tools
    typescript
    nodejs
    nodePackages.npm
  ];

  home.file.".zshrc".source = ./zsh/zshrc;

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  # fonts.packages = with pkgs; [
  #   nerdfonts
  #  (nerdfonts.override { fonts = [ 
  #    "FireCode" 
  #    "SpaceMono" 
  #    "3270" 
  #    "CaskaydiaCove" 
  #    "FantasqueSansM" 
  #    "ShureTechMono" 
  #    "SauceCodePro"
  #    "Symbols"
  #    "Terminess"
  #    "UbuntuMono"
  #    "VictorMono"
  #  ]; })
  # ];
}
