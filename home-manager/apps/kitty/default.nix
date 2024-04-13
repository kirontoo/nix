{
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      update_check_interval = 0;
      linux_display_server="x11";
    };
    extraConfig = ''
      confirm_os_window_close 0
    '';
  };
}


