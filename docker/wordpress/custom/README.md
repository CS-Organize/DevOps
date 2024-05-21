## Starting Alpine Setup & Configuration Alpine

`docker run -it -p 80:80 --name lemp alpine /bin/sh`
- `-i`: interactive, 컨테이너의 stdin을 열어둠. 이를 통해 컨테이너와 상호작용 가능
- `-t`: tty, 가상 터미널을 사용할 수 있게 해줌
- `-p 80:80`: 호스트의 80번 포트와 컨테이너의 80번 포트를 연결
- `--name lemp`: 컨테이너의 이름을 lemp로 지정
- `alpine`: 사용할 이미지
- `/bin/sh`: 컨테이너에서 실행할 명령어

## Installing Nginx
`apk update && apk add nginx && apk add vim`
`nginx`

## Installing PHP
`apk add php-fpm`

### Modify nginx configuration
`vim /etc/nginx/http.d/default.conf`
```conf
# This is a default site configuration which will simply return 404, preventing
# chance access to any other virtualhost.
server {
    listen 80 default_server;
    listen [::]:80 default_server;
 
    root   /var/www/localhost/htdocs;
    index  index.php index.html index.htm;
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    # You may need this to prevent return 404 recursion.
    location = /404.html {
        internal;
    }
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass   0.0.0.0:9000;
        fastcgi_index  index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

`nginx -t`: **Check if the configuration is correct**\
`nginx -s reload`: **Reload the configuration**\
`killall -KILL php-fpm82`: **Kill the PHP-FPM process**\
`/usr/sbin/php-fpm82`: **Start the PHP-FPM process**

### Create a PHP file
`vim /var/www/localhost/htdocs/index.php`
```php
<?php
phpinfo();
```

## Installing WordPress with docker

`docker build . -t lempenv`

`docker run -it -d -v $PWD:/var/www/localhost/htdocs -p 80:80 --name mywp lempenv`
