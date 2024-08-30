# My First Docker

## npm init
```bash
npm init -y

npm install express
```

## Create a server with express
```javascript
const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("🐳 Docker 🐳");
});

app.listen(8080, () => {
  console.log("Server is running on http://localhost:8080/");
});
```

## Dockerfile
```Dockerfile
FROM node:20.12.1-alpine3.18
# 항상 FROM baseImage로 시작해야 한다.
# 기본적으로 순수 linux 이미지를 사용한다.
# node에서 만들어놓은 베이스 이미지가 있다.
# node:<version>-alpine(가장 최소 단위의 리눅스 이미지)

WORKDIR /app
# Container 내부에서 작업할 디렉토리를 설정한다.
# 어떤 Directory에 Application을 복사할 것인지 설정한다.
# `cd /app` 명령어를 실행한 것과 같다.

COPY package.json package-lock.json ./
# `cd package.json package-lock.json ./` 명령어를 실행한 것과 같다.

RUN npm ci
# npm install 명령어를 실행한 것과 같다.
# npm install의 경우 명시한 범위 중 가장 최신 버전을 설치하기 때문에 개발 버전과 배포 버전이 다를 수 있다.
# 따라서 npm ci 명령어를 사용하여 package-lock.json에 명시된 버전을 설치하는 것이 가장 좋다.

COPY index.js ./

ENTRYPOINT ["node", "index.js"]
# ENTRYPOINT는 Container가 시작될 때 실행할 명령어를 설정한다.
# ENTYPOINT [cmd, param1, param2] 형식으로 사용한다.
```
- Dockerfile은 Layer System으로 구성되어 있기 때문에 빈번한 변경이 발생하는 부분은 가장 아래에 배치하는 것이 좋다.
- 실제 Application 소스 코드인 `index.js`가 `package.json`같은 Dependency 파일보다 더 자주 변경되기 때문에 `index.js`를 가장 아래에 배치하는 것이 좋다.
- [Dockerfile reference | Docker Docs](https://docs.docker.com/reference/dockerfile/#entrypoint)
- [Overview of best practices for writing Dockerfiles | Docker Docs](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

## Build Docker Image
```bash
docker build -f Dockerfile -t my-first-docker .
```
- build: Docker Image를 생성하는 명령어
- -f: 어떤 Dockerfile을 사용할 것인지 지정하는 옵션
- -t: Docker Image의 이름을 지정하는 옵션
- .: Dockerfile이 있는 경로를 지정하는 옵션

## Check Docker Image
```bash
docker images
```

## Run Docker Container
```bash
docker run -d -p 8080:8080 my-first-docker
```
- run: Docker Container를 생성하고 실행하는 명령어
- -d: Detached mode(background)로 실행하는 옵션
- -p: Port Mapping 옵션 (Host Port:Container Port)

## Check Docker Container
```bash
docker ps
docker log <Container ID>
```

## Stop Docker Container
```bash
docker stop <Container ID>
```

## Remove Docker Container/Image
```bash
docker rm <Container ID>
docker rmi <Image ID>
```

## Push Docker Image
```bash
docker tag <Image Name> <Docker Hub Username>/<Image Name>:<Tag>
docker login
docker push <Docker Hub Username>/<Image Name>:<Tag>
```
- (image) tag: Personal Docker Hub에 Image를 Push하기 위해서는 <Docker Hub Username>/<Image Name>:<Tag> 형식으로 Tag를 지정해야 한다.
- login: Docker Hub에 로그인하는 명령어
- push: Docker Hub에 Image를 Push하는 명령어
```
