# ДЗ по теме Docker

# 1. Устанавливаем и запускаем docker

curl -sSL httpd://get.docker.com | sh
systemctl enable docker
systemctl start docker

# 2. Копируем необходимые для сборки образа файлы

cp /vagrant/Dockerfile ~
cp /vagrant/nginx.conf ~
cp /vagrant/index.html ~

# 3. Создаем Dockerfile на Alpine

vi Dockerfile


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
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# 4. Собираем образ и запускаем контейнер

docker build -t deepsey/custom_nginx ~
docker run -d --name custom_nginx -p 80:80 deepsey/custom_nginx

# 5. Проверяем работу nginx

curl http://localhost

<center><H1>My NGINX is working!</H1></center>


# 6. Выкладываем образ на docker hub 

docker login
docker push deepsey/custom_nginx

# 7. Образ лежит здесь:

https://hub.docker.com/repository/docker/deepsey/custom_nginx
