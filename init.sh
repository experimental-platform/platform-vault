#!/usr/bin/env sh

set -eu

if ! vault init -check; then
	UNSEAL_KEY=$(vault init -key-shares=1 -key-threshold=1 | head -n1 | sed 's/^Unseal Key 1: //')
	echo "$UNSEAL_KEY" >> /vault_key
fi

vault unseal "$(cat /vault_key)"
