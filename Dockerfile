FROM douglaswei/openresty:fix_json
MAINTAINER Douglas Wei

ADD conf /data/webapps/nginx/conf

EXPOSE 80 443

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;", "-c", "/data/webapps/nginx/conf/nginx.conf"]
