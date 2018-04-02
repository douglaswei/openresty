FROM douglaswei/openresty:base
MAINTAINER Douglas Wei

ARG kafka_host=127.0.0.1
ARG kafka_port=9092

ADD conf /data/webapps/nginx/conf
ADD bin /data/webapps/nginx/bin

#ENV KAFKA_HOST=$kafka_host
ENV KAFKA_PORT=$kafka_port

EXPOSE 80 443

CMD ["sh", "/data/webapps/nginx/bin/start_nginx.sh"]
#CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;", "-c", "/data/webapps/nginx/conf/nginx.conf"]
