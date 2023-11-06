default:
	@just --list --unsorted

update-all:
	sudo dnf update
	flatpak update
	cargo install-update --all
	sudo npm update -g
