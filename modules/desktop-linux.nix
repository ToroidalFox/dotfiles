{ pkgs, ... }:

{
  services.flatpak = {
    enable = true;

    packages = [
      "md.obsidian.Obsidian"
      "com.vysp3r.ProtonPlus"
      "com.protonvpn.www"
    ];
  };

  programs.alacritty = {
    enable = true;
    package = null;
    settings = {
      font = {
        size = 11.0;
        normal = {
          family = "Cascadia Mono";
          style = "Regular";
        };
        bold = {
          family = "Cascadia Mono";
          style = "Bold";
        };
        italic = {
          family = "Cascadia Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Cascadia Mono";
          style = "Bold Italic";
        };
      };
      general.live_config_reload = true;
      colors.draw_bold_text_with_bright_colors = true;
      env.TERM = "alacritty";
      terminal.shell = {
        program = "/usr/bin/env";
        args = ["zsh" "--login"];
      };
      window = {
        option_as_alt = "Both";
        decorations = "full";
        dynamic_padding = true;
        opacity = 1;
        blur = false;
        resize_increments = true;
        dimensions.columns = 110;
        dimensions.lines = 36;
      };
      keyboard.bindings = [
        {key = "Q"; mods = "Control"; action = "Quit";}
        {key = "N"; mods = "Shift|Control"; action = "CreateNewWindow";}
      ];
    };
  };
}
