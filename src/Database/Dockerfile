FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=supersecurepassword
ENV MYSQL_DATABASE=myapp

COPY ./database.sql /docker-entrypoint-initdb.d/

EXPOSE 3306