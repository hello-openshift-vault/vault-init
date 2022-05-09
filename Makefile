.PHONY: install uninstall

install:
	helm dependency update
	helm install \
	    --create-namespace \
	    --namespace vault-server \
	    vault-server .

uninstall:
	helm uninstall \
	     --namespace vault-server \
	     vault-server
	oc delete -n vault-server pvc data-vault-server-0
	oc delete -n vault-server secret vault-recovery-keys
