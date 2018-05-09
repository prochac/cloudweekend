FROM nginx

RUN apt-get update\
    && apt-get install openssl

RUN ["/bin/bash", "-c", "openssl req -x509 -out /etc/nginx/localhost.crt -keyout /etc/nginx/localhost.key \
                          -newkey rsa:2048 -nodes -sha256 \
                          -subj '/CN=localhost' -extensions EXT -config <( \
                           printf \"[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth\")"]

COPY ./html /usr/share/nginx/html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

