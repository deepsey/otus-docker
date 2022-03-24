# ДЗ по теме Docker

#### 1. Устанавливаем и запускаем docker

    curl -sSL https://get.docker.com | sh  
    systemctl enable docker    
    systemctl start docker  

# 2. Копируем необходимые для сборки образа файлы

cp /vagrant/Dockerfile ~
cp /vagrant/nginx.conf ~
cp /vagrant/index.html ~

# 3. Создаем Dockerfile на Alpine

Dockerfile выложен отдельно

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
