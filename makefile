ca:
	-docker rm -v ca-root
	-docker rmi $(IMAGE)
	cat $(ALT) >> ./root/ca/intermediate/openssl.cnf
	docker build -t $(IMAGE) .
	docker run -ti --name=ca-root -v /root/ca $(IMAGE) bash -c "cd /root/ca && ./new.sh"
	git reset --hard

cert:
	-docker rm ca-cert-gen
	docker run -ti --name ca-cert-gen --volumes-from ca-root $(IMAGE) bash -c "cd /root/ca && ./newcert.sh $(NAME)"
	docker cp ca-cert-gen:/root/ca/out $(NAME).certs
	docker rm ca-cert-gen
