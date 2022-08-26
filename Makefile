.PHONY: install uninstall

install:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    vault-server .

uninstall:
	oc delete project vault-server
