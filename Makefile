.PHONY: install install-ha uninstall

ifndef VAULT_SERVER_HOSTNAME
$(error VAULT_SERVER_HOSTNAME is not set. Set with 'export VAULT_SERVER_HOSTNAME="vault.apps.cluster.domain"')
endif

install:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    --set vault.server.route.host="${VAULT_SERVER_HOSTNAME}" \
	    vault-server .

install-ha:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    --values values.yaml \
	    --values values.ha.yaml \
	    --set vault.server.route.host="${VAULT_SERVER_HOSTNAME}" \
	    vault-server .

uninstall:
	helm uninstall \
	    --namespace vault-server \
	    vault-server
	oc delete project vault-server
