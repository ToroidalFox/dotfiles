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

  program.alacritty = {
    enable = true;
  };
}
