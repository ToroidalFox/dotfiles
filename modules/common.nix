{ inputs, config, pkgs, username, isLinux, isDarwin, ... }:

let
  link-farm = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/link-farm/${path}";
in
{
  targets.genericLinux.enable = true;
  home.stateVersion = "26.05";
  home.username = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh
    starship
    ripgrep
    fd
    bat
    git
    jujutsu
    just
    zellij
    fastfetch
    yubikey-manager
    tombi
    nixd
    nil
    btop
    eza
    trash-cli
  ] ++ [
    inputs.mitos.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.file.".justfile".source = link-farm "just-home/.justfile";
  home.file.".config/mitos".source = link-farm "mitos/.config/mitos";
  home.sessionVariables = {
    EDITOR = "ms";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
        size = 10000;
        save = 1000000;
      };

    shellAliases = {
      sudo = "sudo env PATH=$PATH";
      rm = "rm -i";
      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
      es = "eza";
      ea = "eza -a";
      el = "eza -l";
      ela = "eza -la";
      zj = "zellij";
      ff = "fastfetch";
    };

    siteFunctions = {
      justemplate = ''
        if [ ! -f .justfile ]; then cat << EOF > .justfile
[private]
default:
    @just --list --unsorted

[private]
edit:
    @\$EDITOR .justfile
EOF
        fi
      '';
    };
    initContent = ''
      if command -v systemd-detect-virt >/dev/null 2>&1 &&
        [ "$(systemd-detect-virt)" = "wsl" ]; then
        export SSH_SK_HELPER="/mnt/c/Windows/System32/OpenSSH/ssh-sk-helper.exe"
      fi
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    presets = ["plain-text-symbols"];
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "ToroidalFox";
      user.email = "toroidalfox@gmail.com";
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "ToroidalFox";
      user.email = "toroidalfox@gmail.com";

      revsets.log = "ancestors(@, 8) | ancestors(visible_heads(), 8) | ancestors(bookmarks(), 8) | ancestors(remote_bookmarks(), 8) | divergent()";
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      keybinds._props.clear-defaults = true;
      keybinds._children = [
          {shared_except = {_args = ["locked"]; _children = [
            {bind = {_args = ["Ctrl Shift l"]; SwitchToMode = "Locked";};}
            {bind = {_args = ["Ctrl Shift q"]; Quit = {};};}
            {bind = {_args = ["Ctrl Tab" "Alt l"]; GoToNextTab = {};};}
            {bind = {_args = ["Ctrl Shift Tab" "Alt h"]; GoToPreviousTab = {};};}
            {bind = {_args = ["Alt h" "Alt Left"]; MoveFocus = "Left";};}
            {bind = {_args = ["Alt l" "Alt Right"]; MoveFocus = "Right";};}
            {bind = {_args = ["Alt j" "Alt Down"]; MoveFocus = "Down";};}
            {bind = {_args = ["Alt k" "Alt Up"]; MoveFocus = "Up";};}
            {bind = {_args = ["Alt 1"]; GoToTab = 1;};}
            {bind = {_args = ["Alt 2"]; GoToTab = 2;};}
            {bind = {_args = ["Alt 3"]; GoToTab = 3;};}
            {bind = {_args = ["Alt 4"]; GoToTab = 4;};}
            {bind = {_args = ["Alt 5"]; GoToTab = 5;};}
            {bind = {_args = ["Alt 6"]; GoToTab = 6;};}
            {bind = {_args = ["Alt 7"]; GoToTab = 7;};}
            {bind = {_args = ["Alt 8"]; GoToTab = 8;};}
            {bind = {_args = ["Alt 9"]; GoToTab = 9;};}
            {bind = {_args = ["Alt 0"]; GoToTab = 10;};}
          ];};}
          {shared_except = {_args = ["normal" "locked"]; _children = [
            {bind = {_args = ["Esc"]; SwitchToMode = "Normal";};}
          ];};}

          # locked mode
          {locked._children = [
              {bind = {_args = ["Ctrl Shift l"]; SwitchToMode = "Normal";};}
          ];}

          # resize mode
          {shared_except = {_args = ["resize" "locked"]; _children = [
            {bind = {_args = ["Ctrl Shift r"]; SwitchToMode = "Resize";};}
          ];};}
          {resize._children = [
              {bind = {_args = ["Ctrl Shift r"]; SwitchToMode = "Normal";};}
              {bind = {_args = ["h" "Left"]; Resize = "Increase Left";};}
              {bind = {_args = ["l" "Right"]; Resize = "Increase Right";};}
              {bind = {_args = ["j" "Down"]; Resize = "Increase Down";};}
              {bind = {_args = ["k" "Up"]; Resize = "Increase Up";};}
          ];}

          # pane mode
          {shared_except = {_args = ["pane" "locked"]; _children = [
            {bind = {_args = ["Ctrl Shift p"]; SwitchToMode = "Pane";};}
          ];};}
          {pane._children = [
              {bind = {_args = ["Ctrl Shift p"]; SwitchToMode = "Normal";};}
          ];}
      ];
    };
  };
}
