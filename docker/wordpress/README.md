[Docker Compose를 이용하여 워드프레스 설치하기](https://www.wsgvet.com/bbs/board.php?bo_table=ubuntu&wr_id=97)

```markdown
`docker system prune -af --volumes` 명령어는 Docker 시스템에서 사용되지 않는 데이터를 정리하는데 사용됩니다. 
이 명령어는 여러 부분으로 구성된 Docker 리소스를 삭제하여 디스크 공간을 확보할 수 있게 도와줍니다. 

명령어의 각 옵션은 다음과 같은 의미를 가집니다:

- `docker system prune`: Docker에서 사용하지 않는 리소스를 제거하는 명령입니다. 기본적으로, 중단된 컨테이너, 사용하지 않는 네트워크, 빌드 과정에서 생긴 임시 이미지들을 제거합니다.
- `-a` 또는 `--all`: 기본적으로 `docker system prune` 명령은 최근에 사용되지 않은 이미지를 제외하고 삭제합니다. `-a` 옵션을 추가하면, 사용중이지 않은 모든 이미지를 포함하여 더욱 광범위하게 정리합니다. 참조되지 않는 모든 이미지가 대상이 됩니다.
- `-f` 또는 `--force`: 이 옵션은 사용자에게 삭제를 위한 추가적인 확인을 요구하지 않고 바로 명령을 수행하게 합니다.
- `--volumes`: Docker 볼륨은 컨테이너에 데이터를 저장하는 데 사용됩니다. 기본적으로 `docker system prune` 명령은 볼륨을 제거하지 않지만, `--volumes` 옵션을 추가하면 사용하지 않는 모든 볼륨도 제거됩니다. 볼륨 데이터는 중요할 수 있으므로, 이 옵션을 사용할 때는 주의가 필요합니다.

결과적으로, `docker system prune -af --volumes` 명령은 사용자의 확인 없이 사용되지 않는 컨테이너, 네트워크, 이미지, 그리고 볼륨을 모두 삭제하여 시스템을 정리합니다.
이 명령을 사용하기 전에 중요한 데이터가 삭제되지 않도록 주의하십시오. 

[1] velog - Docker - prune 도커 정리하기 (https://velog.io/@zuckerfrei/Docker-prune-%EB%8F%84%EC%BB%A4-%EC%A0%95%EB%A6%AC%ED%95%98%EA%B8%B0)
[2] TISTORY - 도커 리소스 한꺼번에 정리하는 docker prune 명령어 - 조흔개발자 (https://iot-lab.tistory.com/19)
[3] 불친절한 블로그 - [Docker] 도커 리소스 정리(prune) - 불친절한 블로그 - 티스토리 (https://onu0624.tistory.com/152)
[4] lainyzine.com - docker prune 사용법: 사용하지 않는 이미지/컨테이너 일괄 삭제 (https://www.lainyzine.com/ko/article/docker-prune-usage-remove-unused-docker-objects/) 
```
