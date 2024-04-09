{
  programs.kitty = {
    enable = true;
    font.name = "Shure Tech Mono";
    font.size = 16.0;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      linux_display_server="x11";
    };
    extraConfig = ''
      confirm_os_window_close 0
    '';
  };
}


