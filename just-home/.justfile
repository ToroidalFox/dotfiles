[private]
default:
	@just --list --unsorted

edit:
	hx .justfile

mount:
	rclone mount --vfs-cache-mode full --daemon gdrive: ~/GoogleDrive

# update dnf
[linux]
update:
	sudo dnf upgrade

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
[confirm]
boot-macos:
	sudo asahi-bless
	shutdown -r now

[macos]
[confirm]
boot-asahi:
	sudo bless -mount /Volumes/Fedora\ Asahi -setBoot
	sudo shutdown -r now
