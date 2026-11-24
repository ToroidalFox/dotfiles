{ inputs, pkgs, username, isLinux, isDarwin, ... }:

{
  home.packages = with pkgs; [
    tombi
    # opencode
    rtk
    vscode-langservers-extracted
    ruff
    rustup
    clang
    clang-tools
    meson
    ninja
  ] ++ pkgs.lib.optionals isLinux (with pkgs; [
    mold
  ]);

  programs.cargo = {
    enable = true;
    package = null;
    settings = {
      # empty
    } // (pkgs.lib.optionalAttrs isLinux {
      target."cfg(target_os = \"linux\")" = {
        linker = "clang";
        rustflags = ["-C" "link-arg=-fuse-ld=mold"];
      };
    });
  };
  home.sessionPath = ["$CARGO_HOME/config.toml"];
}
