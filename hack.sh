#!/bin/bash

echo 'Initializing vault...'
oc exec -ti vault-server-0 -- \
    vault operator init -format=json > recovery-keys.json

# We will need 3/5 keys to unseal each Vault instance
VAULT_UNSEAL_KEY1=$(jq -r '.unseal_keys_b64[0]' recovery-keys.json)
VAULT_UNSEAL_KEY2=$(jq -r '.unseal_keys_b64[1]' recovery-keys.json)
VAULT_UNSEAL_KEY3=$(jq -r '.unseal_keys_b64[2]' recovery-keys.json)

# We will also need the root token to log in to vault
VAULT_ROOT_TOKEN=$(jq -r '.root_token' recovery-keys.json)

unseal-vault() {
    VAULT_POD_NAME="$1"
    oc exec -ti "$VAULT_POD_NAME" -- vault operator unseal "$VAULT_UNSEAL_KEY1"
    oc exec -ti "$VAULT_POD_NAME" -- vault operator unseal "$VAULT_UNSEAL_KEY2"
    oc exec -ti "$VAULT_POD_NAME" -- vault operator unseal "$VAULT_UNSEAL_KEY3"
}

echo 'Unsealing vault-server-0...'
unseal-vault vault-server-0

echo 'Waiting 30 seconds for vault to unseal...'
sleep 30

echo 'Joining replicas to vault raft...'
oc exec -ti vault-server-1 -- \
    vault operator raft join 'http://vault-server-0.vault-server-internal:8200'
oc exec -ti vault-server-2 -- \
    vault operator raft join 'http://vault-server-0.vault-server-internal:8200'

echo 'Waiting 30 seconds for raft joins to complete...'
sleep 30

echo 'Unsealing replicas...'
unseal-vault vault-server-1
unseal-vault vault-server-2

echo 'Logging into vault-server-0...'
oc exec -it vault-server-0 -- vault login "$VAULT_ROOT_TOKEN"

echo 'Checking raft peers...'
oc exec -it vault-server-0 -- vault operator raft list-peers

echo 'Done!'

