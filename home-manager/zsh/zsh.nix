{
  programs.zsh = {
    enable = true;
    # plugins = [ "git" ];
    # theme = "robbyrussell";
    # enableCompletion = true;
    # autosuggestions.enable = true;
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
  };
}
