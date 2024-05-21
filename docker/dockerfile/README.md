# Docker Practice

```bash
docker run -it node:21.7-alpine3.18
```

```Dockerfile
FROM node:21.7-alpine3.18

WORKDIR /app

COPY package.json .(or /app같은 절대 경로)

RUN npm install
# RUN node app.js
# Image는 Container의 Template이다.
# Image를 실행하는 것이 아닌 Template을 실행하는 것이다.
# RUN과 CMD의 차이점은 RUN은 Image를 빌드할 때 실행되고, CMD는 Container를 실행할 때 실행된다.

EXPOSE 80
# 마지막 명령 전에 로컬 머신과 연결할 포트를 지정한다.
# Documentation 목적으로 사용되며, 실제로 포트를 연결하려면 docker run -p(publish) 80:80 my-first-docker 명령어를 사용한다.
