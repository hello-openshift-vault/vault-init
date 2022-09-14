# Vault Init

Helm chart to deploy a ready-to-go Vault server on Red Hat OpenShift.

This chart extends the official [Vault Helm Chart] to include an init script
which does the following:

- Initialize Vault server
- Saves recovery keys and root key to k8s secret
- Auto join Vault server replicas with Raft
- Auto unseals all Vault server pods using the k8s secret on pod startup

## Deploying

To deploy a standalone Vault server (1 replica), clone this repo and run:

```bash
# Replace VAULT_SERVER_HOSTNAME with the hostname Vault should be deployed to
export VAULT_SERVER_HOSTNAME="vault.apps.change-me.com"
make install
```

To deploy a highly-available Vault server (3 replicas), clone this repo and
run:

```bash
# Replace VAULT_SERVER_HOSTNAME with the hostname Vault should be deployed to
export VAULT_SERVER_HOSTNAME="vault.apps.change-me.com"
make install-ha
```

## Troubleshooting

:warning: You may see *PostStartHookError* events after installing. This should
fix itself once all of the pods are ready. If the errors persist for more than
1 minute, you likely have an actual problem.

[Vault Helm Chart]: https://github.com/hashicorp/vault-helm
