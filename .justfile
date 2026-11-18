[private]
default:
    @just --list --unsorted

[private]
edit:
    @$EDITOR .justfile

[arg('arch', pattern='x8|a8')]
[arg('name', pattern='min|dev|full')]
[linux]
switch name arch:
    home-manager switch --flake .#linux-{{ arch }}-{{ name }} --option warn-dirty false

[arg('arch', pattern='x8|a8')]
[arg('name', pattern='min|dev|full')]
[linux]
init name arch:
    nix run home-manager/release-26.05 -- switch --flake .#linux-{{ arch }}-{{ name }} --option warn-dirty false

[linux]
set-shell shell:
    #!/usr/bin/env bash
    set -euo pipefail

    SHELL_PATH="${HOME}/.nix-profile/bin/{{ shell }}"

    if [[ ! -x "$SHELL_PATH" ]]; then
      echo "Error: $SHELL_PATH does not exist or is not executable" >&2
      exit 1
    fi

    # Add to /etc/shells only if not already present
    if ! grep -qxF "$SHELL_PATH" /etc/shells; then
      echo "Adding $SHELL_PATH to /etc/shells"
      echo "$SHELL_PATH" | sudo tee -a /etc/shells > /dev/null
    else
      echo "$SHELL_PATH is already in /etc/shells"
    fi

    # Change the login shell
    echo "Setting default shell to $SHELL_PATH"
    sudo chsh -s "$SHELL_PATH"

    echo "Done. Log out and back in (or start a new login shell) for the change to take effect."

ghrk id:
    #!/usr/bin/env bash
    set -eo pipefail
    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT

    KEY_NAME="rk{{ id }}-ed25519"
    if [ -n "$SUDO_USER" ]; then
        TARGET_USER="$SUDO_USER"
        USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    else
        TARGET_USER="$(id -un)"
        USER_HOME="$HOME"
    fi
    SSH_DIR="$USER_HOME/.ssh"

    if [ ! -d "$SSH_DIR" ]; then
        mkdir "$SSH_DIR" 
        chown "$TARGET_USER:$(id -gn "$TARGET_USER")" $SSH_DIR
    fi
    cd "$tmpdir"
    ssh-keygen -K
    mv "$(find "$tmpdir" -maxdepth 1 -type f ! -name '*.pub' -print -quit)" "$SSH_DIR/$KEY_NAME"
    mv "$(find "$tmpdir" -maxdepth 1 -type f -name '*.pub' -print -quit)" "$SSH_DIR/$KEY_NAME.pub"
    chown "$TARGET_USER:$(id -gn "$TARGET_USER")" "$SSH_DIR/$KEY_NAME"*

    if [ ! -d "$SSH_DIR/config" ]; then
        touch "$SSH_DIR/config"
        chown "$TARGET_USER:$(id -gn "$TARGET_USER")" "$SSH_DIR/config"
    fi
    cat << EOF >> $SSH_DIR/config

    Host gh{{ id }}
        User git
        HostName github.com
        IdentityFile $TARGET_HOME/.ssh/$KEY_NAME
        IdentitiesOnly yes
    EOF
