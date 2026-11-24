{
  inputs.agent-sandbox.url = "github:archie-judd/agent-sandbox.nix";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, agent-sandbox, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { system = system; };
          sbx = agent-sandbox.lib.${system};
          rustTools = [
            pkgs.cargo
            pkgs.rustc
            pkgs.rustfmt
            pkgs.clippy
            pkgs.rust-analyzer
            pkgs.stdenv.cc
          ];
          otherTools = [
          ];
          opencode-sandboxed = sbx.mkSandbox {
            pkg = pkgs.opencode;
            binName = "opencode";
            outName = "opencode-sandboxed"; # or whatever alias you'd like
            allowedPackages = sbx.commonTools ++ [
              pkgs.eza
              pkgs.bat
              # pkgs.jujutsu
              # pkgs.jjui
            ]
            ++ rustTools
            ++ otherTools
            ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
              pkgs.clang
              pkgs.mold
            ];
            # Uncomment to always work in one directory, wherever you launch from:
            # workspaceDir = "$HOME/projects/my-project";
            rwDirs = [
              "$HOME/.config/opencode"
              "$HOME/.local/share/opencode"
              "$HOME/.local/state/opencode"
              "$HOME/.cache/opencode"
              "$HOME/.cache/cargo" # rust cargo cache and registry
            ];
            rwFiles = [ ];
            roFiles = [ "$HOME/.cargo/config.toml" ];
            roDirs = [ ];
            # For git identity, uncomment to bind your host gitconfig (see README):
            # roFiles = [ "$HOME/.config/git/config" ];
            env = {
              # Pass secrets as shell variable references (e.g. "$TOKEN"), not
              # via builtins.getEnv, so they expand at runtime and stay out of
              # the /nix/store.
              # ANTHROPIC_API_KEY = "$ANTHROPIC_API_KEY";
              # OPENAI_API_KEY = "$OPENAI_API_KEY";
              # GITHUB_TOKEN = "$GITHUB_TOKEN";
              CARGO_HOME = "$HOME/.cache/cargo";
            };
            # opencode is multi-provider: keep the domains of the providers you
            # configure, and drop the rest.
            allowedDomains = {
              "opencode.ai" = "*";
              # "models.dev" = [
              #   "GET"
              #   "HEAD"
              # ];
              # "anthropic.com" = "*";
              # "api.openai.com" = "*";
              "raw.githubusercontent.com" = [
                "GET"
                "HEAD"
              ];
              "api.github.com" = [ "GET" "HEAD" ];
              "crates.io" = [ "GET" "HEAD" ];
            };
          };
        in
        {
          default = pkgs.mkShell {
            packages = [ opencode-sandboxed ] ++ rustTools ++ otherTools;
          };
        }
      );
    };
}
