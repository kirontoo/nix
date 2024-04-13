{ config, pkgs, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/neovim.nix
    ./starship/default.nix
    ./zsh/zsh.nix
    ./fzf/default.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      users.users."daedalus" = {
        description = "main user";
        shell = pkgs.zsh;
      };
      users.defaultUserShell = pkgs.zsh;
      environment.shells = with pkgs; [ zsh ];
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

  # Install kitty config
  xdg.configFile."kitty/" = {
    source = ./apps/kitty/config;
    recursive = true;
  };

  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = "/usr/bin/sudo /usr/bin/chmod -R 777 $HOME/.nix-profile/share/applications && /usr/bin/update-desktop-database $HOME/.nix-profile/share/applications";
    };
  };

  home.sessionVariables = {
    TERM = "kitty";
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
    vivaldi

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
    dbeaver

    # Javascript Development Tools
    typescript
    nodejs
    nodePackages.npm
  ];

  home.file.".zshrc".source = ./zsh/zshrc;

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
}
