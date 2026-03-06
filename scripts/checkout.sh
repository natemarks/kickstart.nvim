#!/usr/bin/env bash
# this only updates the nvim config. it doesn' destroy cache
CONFIG="${HOME}/.config/nvim"
CONFIG_BACKUP="${HOME}/.config/nvim.backup"
BRANCH="${1:-master}"

if [[ ! -d "${CONFIG_BACKUP}" ]]; then
  echo moving "${CONFIG} to ${CONFIG_BACKUP}"
  mv "${CONFIG}" "${CONFIG_BACKUP}"
fi

rm -rf "${CONFIG}"

git clone https://github.com/natemarks/kickstart.nvim.git "${HOME}/.config/nvim"
git -C "${HOME}/.config/nvim" checkout "${BRANCH}"
