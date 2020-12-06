FROM ubuntu:20.04

WORKDIR /app
RUN apt-get update && apt-get -y install nginx
RUN useradd -u 1001 nginx
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R nginx:nginx /app/
EXPOSE 8000

CMD /usr/sbin/nginx -g "daemon off;"
