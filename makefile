ca:
	-docker rm -v ca-root
	docker run -ti --name=ca-root -v /root/ca umegaya/caer bash -c "cd /root/ca && ./new.sh"

cert:
	-docker rm ca-cert-gen
	docker run -ti --name ca-cert-gen --volumes-from ca-root umegaya/caer bash -c "cd /root/ca && ./newcert.sh $(NAME)"
	docker cp ca-cert-gen:/root/ca/out $(NAME).certs
	docker rm ca-cert-gen
