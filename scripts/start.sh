docker build -t douglaswei/openresty:v1.0 .
docker run --name nginx-dou -v /data/logs/nginx/:/data/logs/nginx -e "KAFKA_HOST=172.17.176.47" -p 80:80 -p 443:443 -d douglaswei/openresty:v1.0
