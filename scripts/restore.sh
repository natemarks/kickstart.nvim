#!/usr/bin.env bash
CONFIG="${HOME}/.config/nvim
SHARE="${HOME}/.local/share/nvim
CONFIG_BACKUP="${HOME}/.config/nvim.backup
SHARE_BACKUP="${HOME}/.local/share/nvim.backup


exit
cp -R "${CONFIG_BACKUP}" "${CONFIG}"
cp -R "${SHARE_BACKUP}" "${SHARE}"

mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.config/nvim/ ~/.config/nvim.backup
