.PHONY: install uninstall

install:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    vault-server .

install-ha:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    --values values.ha.yaml \
	    vault-server .

uninstall:
	helm uninstall \
	    --namespace vault-server \
	    vault-server
	oc delete project vault-server
