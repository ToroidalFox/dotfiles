default:
	@just --list --unsorted

[linux]
update-all:
	sudo dnf update
	flatpak update
	cargo install-update --all
	sudo npm update -g

[linux]
#[confirm]
boot-macos:
	sudo asahi-bless
	# shutdown -r now
