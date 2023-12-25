[private]
default:
	@just --list --unsorted

# update dnf
[linux]
update:
	sudo dnf upgrade --refresh --exclude=kwin,kwin-common,kwin-libs,kwin-wayland

# update dnf, flatpak, rustup, cargo, npm
[linux]
update-all: update
	flatpak update -y
	rustup update
	cargo install-update --all
	sudo npm update -g

# brew update, upgrade
[macos]
update:
	brew update
	brew upgrade

[linux]
boot-macos:
	sudo asahi-bless
	shutdown -r now

[macos]
boot-asahi:
	sudo bless -mount /Volumes/Fedora\ Asahi -setBoot
	sudo shutdown -r now
