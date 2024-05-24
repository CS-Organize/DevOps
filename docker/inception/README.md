- [Docker Compose를 이용하여 워드프레스 설치하기 > 우분투 서버 | 우성짱의 NAS](https://www.wsgvet.com/bbs/board.php?bo_table=ubuntu&wr_id=97)
- [custom setup](https://codingwithmanny.medium.com/custom-wordpress-docker-setup-8851e98e6b8)
- [Setup WordPress on Ubuntu 22.04 with Nginx and MariaDB | Works With The Web](https://www.workswiththeweb.com/wordpress/2024/01/14/Setup-WordPress-Ubuntu-Nginx/)
- [docker-compose syntex](https://nirsa.tistory.com/79)
- [Dockerfile](https://adjh54.tistory.com/414)
- [docker-compose: difference between networks and links - Stack Overflow](https://stackoverflow.com/questions/41294305/docker-compose-difference-between-networks-and-links)
- [Docker Volume Tutorial](https://seosh817.tistory.com/374)

Docker 볼륨 내의 컨텐츠를 확인하는 방법 중 하나는 Docker 컨테이너를 사용하여 해당 볼륨을 마운트하고, 그 내부를 탐색하는 것입니다. 위에서 제공된 출력을 바탕으로, `srcs_dbdata` 볼륨 안의 컨텐츠를 확인하는 방법을 설명하겠습니다.

1. **임시 컨테이너 생성 및 볼륨 마운트**

볼륨 내용을 확인하기 위해, 임시 컨테이너를 생성하고 `srcs_dbdata` 볼륨을 마운트할 수 있습니다. 이를 위해, 일반적으로 사용되는 `alpine` 이미지(또는 다른 Linux 배포판)를 사용할 수 있습니다. `alpine`은 가벼운 Linux 배포판으로, 파일 탐색에 필요한 기본 도구를 제공합니다.

```bash
docker run -it --rm --volume srcs_dbdata:/data alpine sh
```

위 명령어는 다음과 같이 작동합니다:
- `docker run`: 새로운 컨테이너를 실행합니다.
- `-it`: 대화형 터미널을 활성화합니다.
- `--rm`: 컨테이너가 종료되면 자동으로 제거합니다.
- `--volume srcs_dbdata:/data`: `srcs_dbdata` 볼륨을 컨테이너의 `/data` 디렉토리에 마운트합니다.
- `alpine`: 사용할 이미지입니다.
- `sh`: 실행할 명령입니다. `sh` 셸을 시작합니다.

2. **볼륨 내부 탐색**

컨테이너 내부에서 `/data` 디렉토리로 이동하여 볼륨 내부를 탐색할 수 있습니다.

```bash
cd /data
ls -l
```

- `cd /data`: `/data` 디렉토리로 이동합니다.
- `ls -l`: 현재 디렉토리의 파일 및 디렉토리 목록을 상세하게 출력합니다.

3. **필요한 작업 수행**

볼륨 내부에서 필요한 모든 작업을 수행할 수 있습니다. 예를 들어, 파일을 읽거나, 수정하거나, 새 파일을 생성할 수 있습니다.

4. **컨테이너 종료**

작업을 마친 후에는 `exit` 명령을 입력하여 컨테이너에서 나갈 수 있습니다. `--rm` 플래그가 설정되어 있으므로, 컨테이너는 자동으로 제거됩니다.

이 방법을 사용하면 별도의 서비스 중단 없이 Docker 볼륨 내의 데이터를 안전하게 탐색하고 관리할 수 있습니다. 

- [1 Learn Microsoft - 볼륨 인식 방법 - Windows drivers ](https://learn.microsoft.com/ko-kr/windows-hardware/drivers/ifs/how-the-volume-is-recognized)
- [2 Autodesk - Flame에 대한 vic(볼륨 무결성 확인) 사용 방법](https://www.autodesk.co.kr/support/technical/article/caas/sfdcarticles/sfdcarticles/KOR/Using-vic-Volume-Integrity-Check.html)
- [3 AWS Documentation - Amazon EBS 볼륨에 대한 정보 보기](https://docs.aws.amazon.com/ko_kr/ebs/latest/userguide/ebs-describing-volumes.html)
- [4 Microsoft Community - 사내 전체 볼륨 라이센스 제품키 확인](https://answers.microsoft.com/ko-kr/windows/forum/all/%EC%82%AC%EB%82%B4-%EC%A0%84%EC%B2%B4/079b4530-5b1b-4025-b410-334cf6cf55e7) 
