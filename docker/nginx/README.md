# Nginx Container

## How to learn

[Nginx - Alpine Linux](https://wiki.alpinelinux.org/wiki/Nginx)
### Experiment with the base image of alpine linux
42과제인 Inception 프로젝트에서 베이스 이미지로 사용할 Alpine linux 컨테이너에 대한 실험을 위해 베이스 이미지만 사용 후, 컨테이너에 원격으로 접속하여 실행을 진행했다.

```Dockerfile
FROM alpine:3.18

# CMD tail -f /dev/null
# CMD while true; do sleep 100; done
```

```bash
docker build -t alpine:3.18 .
docker run -d --name alpine -p 80:80 -p 443:443 alpine:3.18
```

~~이 방식으로 진행하려 했으나, nginx을 재시작하기 위해 필요한 명령어인 `service`, `systemctl` 등이 없어서 그냥 `Dockerfile`을 수정 후 재시작하는 방법으로 진행했다.~~\
\
~~찾아보니 컨테이너에서 `nginx -s reload`를 통해 nginx를 다시 시작할 수 있었다.\
근데 vscode에서 컨테이너에 접속하니 CPU 자원을 엄청나게 사용해서 그냥 `Dockerfile`을 수정 후 재시작하는 방법으로 진행했다.~~

`docker exec -it alpine /bin/sh`를 통해서 컨테이너에 접속한 후, `nginx -s reload`를 통해 nginx를 재시작할 수 있었다.

### Install Nginx on Alpine Linux
[Alpine Linux SSL Setup](https://www.cyberciti.biz/faq/how-to-install-letsencrypt-free-ssltls-for-nginx-certificate-on-alpine-linux/)을 참고해서 Nginx를 설치하고,
[Docker Port Forwarding](https://blue-beam.tistory.com/entry/Docker-%EC%BB%A8%ED%85%8C%EC%9D%B4%EB%84%88-%ED%8F%AC%ED%8A%B8-%EC%97%B0%EA%B2%B0-%ED%8F%AC%ED%8A%B8%ED%8F%AC%EC%9B%8C%EB%94%A9)을 참고해서 포트포워딩을 설정했다.

```Dockerfile
FROM alpine:3.18

RUN apk update && apk add nginx

EXPOSE 80/tcp 443/tcp

CMD ["nginx", "-g", "daemon off;"]
```

### Configure Nginx

[nginx 공식 문서](https://www.nginx.com/resources/wiki/start/)와 [Nginx Docs](https://docs.nginx.com/nginx/admin-guide/web-server/web-server/)를 봐도 각 블록이 어떤 의미인지 알기 어려워서 [Understanding the Nginx Configuration File Structure and Configuration Contexts | DigitalOcean](https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts)을 참고했다.

[Running the NGINX Server in a Docker Container](https://www.baeldung.com/linux/nginx-docker-container)을 참고해서 Nginx 설정을 진행했다.

```nginx.conf
server {
    listen 80 default_server; # 80번 포트를 사용하고, 기본 서버로 설정한다. IPv4
    listen [::]:80 default_server; # 윗줄과 동일하나, IPv6
    
    root /etc/nginx/html; # 웹 서버의 루트 디렉토리를 설정한다.
    index index.html index.htm; # 기본 문서를 설정(우선순위 순서대로)

    server_name _; # 현재 서버 블록의 이름을 설정한다. _는 모든 도메인을 의미한다.
    # 특정 경로에 대한 설정을 정의하는 블록
    location / {
        try_files $uri $uri/ =404; # url로 요청받은 파일이나 디렉토리가 존재하지 않을 경우 404 에러를 반환한다.
    }
}
```

[NGINX: Create Custom 404 / 403 Error Pages on Linux or Unix](https://www.cyberciti.biz/faq/howto-nginx-customizing-404-403-error-page/)을 참고해서 404 에러 페이지를 설정했다.

```nginx.conf
    ...
    error_page 404 /404.html; # 404 에러가 발생했을 때, 404.html 파일을 반환한다.

    # /404.html 경로에 대한 설정을 정의하는 블록
    location  /404.html {
        internal; # 이 위치의 페이지는 내부 오류 페이지로만 사용할 수 있다. 직접 접근할 수 없다.
    }
```

```Dockerfile
# Base image
FROM alpine:3.18

RUN apk update && apk add nginx && mkdir -p /var/www/html

# Copy the configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /etc/nginx/html/index.html
COPY 404.html /etc/nginx/html/404.html

# Port to expose
EXPOSE 80/tcp

CMD ["nginx", "-g", "daemon off;"]
```

이 상태로 빌드 후 실행을 진행했는데 오류가 발생했다.\
[nginx: [emerg] "server" directive is not allowed here - Stack Overflow](https://stackoverflow.com/questions/41766195/nginx-emerg-server-directive-is-not-allowed-here) 이유는 `nginx.conf` 파일의 문법 오류였다.

```nginx.conf

events {
    # 워커 프로세스가 동시에 처리할 수 있는 커넥션의 수를 설정한다.
    # worker_connections  1024;  ## Default: 1024
}

http {
    # 하나의 서버를 정의하는 블록
    server {
        listen 80 default_server; # 80번 포트를 사용하고, 기본 서버로 설정한다. IPv4
        listen [::]:80 default_server; # 윗줄과 동일하나, IPv6

        root /etc/nginx/html; # 웹 서버의 루트 디렉토리를 설정한다.
        index index.html index.htm; # 기본 문서를 설정(우선순위 순서대로)

        server_name _; # 현재 서버 블록의 이름을 설정한다. _는 모든 도메인을 의미한다.

        # 특정 경로에 대한 설정을 정의하는 블록
        location / {
            try_files $uri $uri/ =404; # url로 요청받은 파일이나 디렉토리가 존재하지 않을 경우 404 에러를 반환한다.
        }

        error_page 404 /404.html; # 404 에러가 발생했을 때, 404.html 파일을 반환한다.

        # /404.html 경로에 대한 설정을 정의하는 블록
        location /404.html {
            internal; # 이 위치의 페이지는 내부 오류 페이지로만 사용할 수 있다. 직접 접근할 수 없다.
        }
    }
}
```

[Full Example Configuration | NGINX](https://www.nginx.com/resources/wiki/start/topics/examples/full/)을 보고 access_log, error_log, client_max_body_size 설정을 추가했다.

```nginx.conf
    ...
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ...
    client_max_body_size 10m;
```

`/etc/nginx/html`에 있는 html 파일은 잘 불러왔지만, `style.css` 파일을 불러오지 못하는 문제가 발생했다.\
찾아보니 [MIME](https://developer.mozilla.org/ko/docs/Web/HTTP/Basics_of_HTTP/MIME_Types) 타입을 설정해주지 않아서 발생한 문제였다.\
nginx 설치 시 기본적으로 생성되는 `/etc/nginx/mime.types` 파일을 include 해주면 해결된다.

```nginx.conf
    ...
    include /etc/nginx/mime.types;
```

그런데 문득 `/etc/nginx/html/` 디렉토리 안에 css 파일을 넣어놓는 것이 파일 구조 상 좋지 않다고 생각했다.\
그리고 nginx 설정에 대한 많은 글들을 찾아보았는데 `/var/lib/nginx/`, `/var/www/`, `/etc/nginx/` 등 다양한 root 디렉토리를 사용하는 것을 보았다.\
[NGinx Default public www location? - Stack Overflow](https://stackoverflow.com/questions/10674867/nginx-default-public-www-location) 글을 보니 `nginx -V` 명령어를 통해 기본 루트 디렉토리를 확인할 수 있다고 해서, container에 접속해서 확인해보았다.

```bash
> nginx -V
nginx version: nginx/1.24.0
built with OpenSSL 3.1.3 19 Sep 2023 (running with OpenSSL 3.1.4 24 Oct 2023)
TLS SNI support enabled
configure arguments: --prefix=/var/lib/nginx ...
```

alpine linux 환경에서는 `/var/lib/nginx/` 디렉토리를 root 디렉토리로 사용하며, nginx 설치 시 기본적으로 생성되는 html 파일들이 들어있는 것을 확인했다.\
기본 디렉토리 경로를 굳이 수정할 이유가 없기 때문에 기본 디렉토리를 사용하기로 했다.

```Dockerfile
# Base image
FROM alpine:3.18

RUN apk update && apk add nginx && mkdir -p /var/www/html /var/www/css

# Copy the configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/index.html
COPY 404.html /var/www/html/404.html
COPY style.css /var/www/css/style.css

# Port to expose
EXPOSE 80/tcp

CMD ["nginx", "-g", "daemon off;"]
```

```nginx.conf
events {
    # 워커 프로세스가 동시에 처리할 수 있는 커넥션의 수를 설정한다.
    # worker_connections  1024;  ## Default: 1024
}

http {
    include /etc/nginx/mime.types;
    # Logging settings
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    # 하나의 서버를 정의하는 블록
    server {
        listen 80 default_server; # 80번 포트를 사용하고, 기본 서버로 설정한다. IPv4
        listen [::]:80 default_server; # 윗줄과 동일하나, IPv6

        root /var/www; # 웹 서버의 루트 디렉토리를 설정한다.
        index index.html index.htm; # 기본 문서를 설정(우선순위 순서대로)

        server_name _; # 현재 서버 블록의 이름을 설정한다. _는 모든 도메인을 의미한다.

        # 특정 경로에 대한 설정을 정의하는 블록
        location / {
            try_files $uri $uri/ =404; # url로 요청받은 파일이나 디렉토리가 존재하지 않을 경우 404 에러를 반환한다.
        }

        error_page 404 /html/404.html; # 404 에러가 발생했을 때, 404.html 파일을 반환한다.

        # /404.html 경로에 대한 설정을 정의하는 블록
        location /html/404.html {
            internal; # 이 위치의 페이지는 내부 오류 페이지로만 사용할 수 있다. 직접 접근할 수 없다.
        }

        # Client request size limit: 클라이언트가 보낼 수 있는 요청 본문의 최대 크기를 제한하여 이는 대량의 데이터 업로드를 방지하거나 DDoS 공격을 완화하는 데 도움
        client_max_body_size 10m;
    }
}
```

### SSL Configuration
- [사이드카 컨테이너로 TLS 사용 - Azure Container Instances | Microsoft Learn](https://learn.microsoft.com/ko-kr/azure/container-instances/container-instances-container-group-ssl)
- [[홈서버 구축기] SSL 인증서 만들기 (연습) - 천의무봉](https://blog.hangadac.com/2017/07/31/%ED%99%88%EC%84%9C%EB%B2%84-%EA%B5%AC%EC%B6%95%EA%B8%B0-ssl-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EC%97%B0%EC%8A%B5/)
- [How to generate a self-signed SSL certificate using OpenSSL? - Stack Overflow](https://stackoverflow.com/questions/10175812/how-to-generate-a-self-signed-ssl-certificate-using-openssl)
- [Docker 설치하고, Docker로 웹 어플리케이션 배포해보기](https://wnsgml972.github.io/setting/2020/07/20/docker/)
