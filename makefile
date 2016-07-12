ca:
	docker run --rm -ti -v `pwd`/root:/root umegaya/caer bash -c "cd /root/ca && new.sh"

key:
	docker run --rm -ti -v `pwd`/root:/root umegaya/caer bash -c "cd /root/ca && newcert.sh $(CN)"
