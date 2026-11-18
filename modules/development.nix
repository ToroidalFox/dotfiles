{ inputs, pkgs, username, isLinux, isDarwin, ... }:

{
  home.packages = with pkgs; [
    tombi
    opencode
    vscode-langservers-extracted
    ruff
  ];
}
