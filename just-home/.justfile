[private]
default:
	@just --list --unsorted

# update dnf
[linux]
update:
	sudo dnf update --refresh

# update dnf, flatpak, rustup, cargo, npm
[linux]
update-all:
	sudo dnf update --refresh
	flatpak update -y
	rustup update
	cargo install-update --all
	sudo npm update -g

[linux]
update-manual:
	@echo "ArmCord: https://github.com/ArmCord/ArmCord/releases"
	@echo "overGrive: https://www.overgrive.com/"

# brew update, upgrade
[macos]
update:
	brew update
	brew upgrade

#[confirm]
[linux]
boot-macos:
	sudo asahi-bless
	@echo "shutdown -r now"

#[confirm]
[macos]
boot-asahi:
	sudo bless -mount /Volumes/Fedora\ Asahi -setBoot
	@echo "sudo shutdown -r now"
