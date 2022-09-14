# Vault Init

Helm chart to deploy a ready-to-go Vault server on Red Hat OpenShift.

This chart extends the official [Vault Helm Chart] to include an init script
which does the following:

- Initialize Vault server
- Saves recovery keys and root key to k8s secret
- Auto join Vault server replicas with Raft
- Auto unseals all Vault server pods using the k8s secret on pod startup

## Deploying

:warning: You may see *PostStartHookError* after installing. This should fix
itself once all of the pods are ready. If it persists for more than 1 minute,
you likely have an actual problem.

### Single Instance

```bash
make install
```

### Highly Available

```bash
make install-ha
```

## Uninstall

```bash
make uninstall
```

[Vault Helm Chart]: https://github.com/hashicorp/vault-helm
