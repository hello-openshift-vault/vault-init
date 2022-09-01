# Vault Init

Helm chart to deploy a ready-to-go Vault server on Red Hat OpenShift.

This chart extends the official [Vault Helm Chart] to include an init script
which does the following:

- Initialize Vault server
- Saves recovery keys and root key to k8s secret
- Auto join Vault server replicas with Raft
- Auto unseals all Vault server pods using the k8s secret on pod startup

## Deploy - Single Instance

```bash
make install
```

## Deploy - HA

```bash
make install-ha
```

## Uninstall

```bash
make uninstall
```

[Vault Helm Chart]: https://github.com/hashicorp/vault-helm
