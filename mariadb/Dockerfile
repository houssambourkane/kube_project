FROM mariadb

COPY ./langue.sql /var/lib/mysql/

COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

