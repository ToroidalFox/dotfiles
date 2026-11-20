{ pkgs, ... }:

{
  services.flatpak = {
    enable = true;

    packages = [
      "md.obsidian.Obsidian"
    ];
  };
}
