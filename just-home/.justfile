default:
	@just --list --unsorted

[linux]
update-all:
	sudo dnf update
	flatpak update
	cargo install-update --all
	sudo npm update -g

#[confirm]
[linux]
boot-macos:
	sudo asahi-bless
	# shutdown -r now

#[confirm]
[macos]
boot-asahi:
	sudo bless -mount /Volumes/Fedora\ Asahi -setBoot
	@echo "sudo shutdown -r now"
