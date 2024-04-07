{ config, pkgs, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/neovim.nix
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
  
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ./nvpunk/default.nix{}).nvpunk;
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
    gotop
    go
    python3
    nodejs_21
    thunderbird
    nerdfonts
  ];
  programs.home-manager.enable = true;
}
