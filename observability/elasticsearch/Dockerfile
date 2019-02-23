FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.2

RUN cd /usr/share/elasticsearch && \
    ./bin/elasticsearch-plugin install -b https://distfiles.compuscene.net/elasticsearch/elasticsearch-prometheus-exporter-6.2.2.0.zip


# docker build -t ozyab/loadbalancer-elasticsearch .

