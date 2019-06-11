FROM mariadb:latest

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN apt-get update \
    && apt-get install multitail

CMD ["mysqld"]

EXPOSE 3306