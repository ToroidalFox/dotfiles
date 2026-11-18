[private]
default:
    @just --list --unsorted

edit:
    @$EDITOR .justfile

authgen *query:
    ykman oath accounts code {{ query }}

[linux]
authcp query:
    @echo && ykman oath accounts code --single {{ query }} | tee /dev/tty | wl-copy --trim-newline

[macos]
authcp query:
    @ykman oath accounts code --single {{ query }} | tee /dev/tty | tr -d '[:space:]' | pbcopy

[confirm]
[linux]
boot-macos:
    sudo asahi-bless --set-boot 1 --yes
    shutdown -r now

[confirm]
[macos]
boot-asahi:
    sudo bless -mount /Volumes/Fedora Asahi Remix -setBoot
    sudo shutdown -r now
