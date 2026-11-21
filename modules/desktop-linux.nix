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

      # breeze (dark)
      # colors.primary = {
      #   background = "#161718";
      #   bright_foreground = "#ffffff";
      #   dim_foreground = "#eff0f1";
      #   foreground = "#fcfcfc" ;
      # };
      # colors.bright = {
      #   black = "#7f8c8d";
      #   red = "#c0392b";
      #   yellow = "#fdbc4b";
      #   green = "#1cdc9a";
      #   blue = "#3daee9";
      #   magenta = "#8e44ad";
      #   cyan = "#16a085";
      #   white = "#ffffff";
      # };
      # colors.normal = {
      #   black = "#232627";
      #   red = "#ed1515";
      #   yellow = "#f67400";
      #   green = "#11d116";
      #   blue = "#1d99f3";
      #   magenta = "#9b59b6";
      #   cyan = "#1abc9c";
      #   white = "#fcfcfc";
      # };
      # colors.dim = {
      #   black = "#31363b";
      #   red = "#783228";
      #   yellow = "#b65619";
      #   green = "#17a262";
      #   blue = "#1b668f";
      #   magenta = "#614a73";
      #   cyan = "#186c60";
      #   white = "#63686d" ;
      # };

      # breeze (light)
      colors.primary = {
        background = "#fafafa";
        bright_foreground = "#050224";
        dim_foreground = "#44424c";
        foreground = "#383a42";
      };
      colors.bright = {
        black = "#1c1a24";
        red = "#f83636";
        yellow = "#de6602";
        green = "#50c850";
        blue = "#005ce8";
        magenta = "#ba0eb8";
        cyan = "#00aac8";
        white = "#ffffff";
      };
      colors.normal = {
        black = "#383a42";
        red = "#e4564a";
        yellow = "#c28402";
        green = "#50a050";
        blue = "#0070d4";
        magenta = "#a626a4";
        cyan = "#0a96b4";
        white = "#fafafa";
      };
      colors.dim = {
        black = "#44424c";
        red = "#c6605e";
        yellow = "#ae9802";
        green = "#648c64";
        blue = "#1484c0";
        cyan = "#1eaaa0";
        magenta = "#885488";
        white = "#e6e6e6";
      };
    };
  };
}
