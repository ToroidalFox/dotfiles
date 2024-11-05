[private]
default:
	@just --list --unsorted

edit:
	@$EDITOR .justfile

init: gh mount

gh:
	gh auth status

mount:
	rclone mount --vfs-cache-mode full --daemon gdrive: ~/GoogleDrive

authgen:
	ykman oath accounts code

[linux]
update:
	sudo dnf upgrade

[linux]
update-all: update
	sudo npm update -g
	flatpak update -y
	rustup update
	cargo install-update --all

[linux]
fcitx-as:
	mv .config/autostart_unused/org.fcitx.Fcitx5.desktop .config/autostart

[linux]
fcitx-nas:
	mv .config/autostart/org.fcitx.Fcitx5.desktop .config/autostart_unused

[linux]
kime-as:
	mv .config/autostart_unused/kime.desktop .config/autostart

[linux]
kime-nas:
	mv .config/autostart/kime.desktop .config/autostart_unused

# @update update_mode="":
# 	if [[ "{{update_mode}}" = "all" ]]; then \
# 		echo "$(tput bold)sudo dnf upgrade$(tput sgr0)"; \
# 		sudo dnf upgrade; \
# 		echo "$(tput bold)flatpak update -y$(tput sgr0)"; \
# 		flatpak update -y; \
# 		echo "$(tput bold)rustup update$(tput sgr0)"; \
# 		rustup update; \
# 		echo "$(tput bold)cargo install-update --all$(tput sgr0)"; \
# 		cargo install-update --all; \
# 		echo "$(tput bold)sudo npm update -g$(tput sgr0)"; \
# 		sudo npm update -g; \
# 	elif [[ "{{update_mode}}" = "" ]]; then \
# 		sudo dnf upgrade; \
# 	fi

# brew update, upgrade
[macos]
update:
	brew update
	brew upgrade

[linux]
[confirm]
boot-macos:
	sudo asahi-bless --set-boot 1 --yes
	shutdown -r now

[macos]
[confirm]
boot-asahi:
	sudo bless -mount /Volumes/Fedora\ Asahi -setBoot
	sudo shutdown -r now
