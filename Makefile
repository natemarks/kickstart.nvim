.DEFAULT_GOAL := help
.PHONY: shellcheck restore deploy
DEFAULT_BRANCH := master
SHELL := /bin/bash
PRJ := $(PWD)
COMMIT := $(shell git rev-parse HEAD)


help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

shellcheck: ## use black to format python files
	( \
       git ls-files 'scripts/*.sh' |  xargs shellcheck --format=gcc; \
    )

stylus: ## run stylua formatter
	( \
       stylua .; \
    )

restore: ## restore original config and share
	bash scripts/restore.sh

deploy: ## restore original config and share
	bash scripts/deploy.sh

