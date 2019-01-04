IMAGE=docker.elastic.co/elasticsearch/elasticsearch:5.1.2
PORT1=9200
PORT2=9300
CONTAINER_ID=$(shell docker container ls | awk '$$2 == "'${IMAGE}'" {print $$1}')

container-id:
	@echo ${CONTAINER_ID}

start:
	docker run -itd \
	-e "xpack.security.enabled=false" \
	-e "ES_JAVA_OPTS=-Xms1g -Xmx1g" \
	-p ${PORT1}:${PORT1} -p ${PORT2}:${PORT2} ${IMAGE}

stop:
	docker stop ${CONTAINER_ID}

restart: stop start

remove:
	docker container rm ${CONTAINER_ID}

check-running:
	@if [ -z "${CONTAINER_ID}" ]; then\
		make start;\
    fi \

status:
	@curl -f -s docker:${PORT1} > /dev/null && echo ok || echo fail
