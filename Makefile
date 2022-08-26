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
	oc delete project vault-server
