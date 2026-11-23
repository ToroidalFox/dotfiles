{ inputs, pkgs, username, isLinux, isDarwin, ... }:

{
  home.packages = with pkgs; [
    tombi
    # opencode
    vscode-langservers-extracted
    ruff
    rustup
    clang
    mold
  ];

  programs.cargo = {
    enable = true;
    package = null;
    settings = {
      target."cfg(target_os = \"linux\"))" = {
        linker = "clang";
        rustflags = ["-C" "link-arg=-fuse-ld=mold"];
      };
    };
  };
  home.sessionPath = ["$CARGO_HOME/config.toml"];
}
