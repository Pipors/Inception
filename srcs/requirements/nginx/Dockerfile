FROM	alpine:3.18


RUN		apk update && apk upgrade && apk add --no-cache nginx openssl


RUN		mkdir -p /etc/nginx/ssl/


RUN		openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
		-keyout /etc/nginx/ssl/aatbir.42.fr.key \
		-out /etc/nginx/ssl/aatbir.42.fr.crt \
		-subj "/C=MA/L=Cabo/O=42/OU=1337 MED/CN=aatbir.42.fr"


COPY	./conf/nginx.conf	/etc/nginx/http.d/nginx.conf


EXPOSE	443


CMD 	["nginx", "-g", "daemon off;"]