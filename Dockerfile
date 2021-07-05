FROM alpine:3.12
RUN echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community >> /etc/apk/repositories
RUN apk update
RUN apk add bash-completion \
    && apk add nginx
RUN mkdir -p /run/nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
ADD nginx.conf /etc/nginx/
ADD index.html /www/
ENTRYPOINT ["nginx","-g","daemon off;"]
