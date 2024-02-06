# Git

[Git Reference](https://git-scm.com/docs)

`git help`, `man git`, `git <command> --help` 명령어를 통해 각 명령어의 사용법을 확인할 수 있다.

## Git Command Workflow

![](./img/GitWorkflow.png)

## Git Branch

### Git Branch Model
- [{Git,Github,Gitlab} Flow 1](https://ujuc.github.io/2015/12/16/git-flow-github-flow-gitlab-flow/)
- [{Git,Github,Gitlab} Flow 2](https://wiki.yowu.dev/ko/dev/Git/about-git-github-gitlab-flow)
- [Trunk Based Development](https://trunkbaseddevelopment.com)
- [Trunk Based Development 기술 블로그](https://tech.mfort.co.kr/blog/2022-08-05-trunk-based-development/)

### Git Branch Policy
- [Branch Protection Rule](https://docs.github.com/ko/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule)
- [CODEOWNERS file](https://docs.github.com/ko/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)

## Git Command

### reset
- `git reset <hash>` : 특정 커밋으로 되돌린다.
	- `HEAD^` : 바로 이전 커밋으로 되돌린다.
	- `HEAD~<number>` : number만큼 이전 커밋으로 되돌린다.
- `git reset --hard <hash>` : 특정 커밋으로 되돌린다. 이전 커밋 이후의 변경사항을 모두 삭제한다.
- `git reset --soft <hash>` : 특정 커밋으로 되돌린다. 이전 커밋 이후의 변경사항을 스테이징 영역에 추가한다.
- `git reset <staged files>` : 스테이징된 파일을 언스테이징한다.

### restore
- `git restore <modified file>` : 파일을 수정하기 전 상태로 되돌린다.
- `git restore --staged <file>` : 스테이징된 파일을 언스테이징한다.
- `git restore --source=<hash> <file>` : 특정 커밋의 파일을 수정하기 전 상태로 되돌린다.

### fetch
- `git fetch` : 원격 저장소의 변경사항을 로컬 저장소로 가져온다.

### stash
1. remote repository에서 pull을 받기 전에 local repository의 변경사항을 임시로 저장할 때
2. local repository에서 다른 branch로 이동하기 전에 변경사항을 임시로 저장할 때

- `git stash` : 변경사항을 임시로 stack에 저장한다.
- `git stash -m` : stash에 메시지를 추가한다.
- `git stash list` : stash 목록을 확인한다.
- `git stash show` : stash 목록을 확인한다.
- `git stash clear` : stash 목록을 삭제한다.
- `git stash apply` : 가장 최근 stash를 적용한다.
- `git stash pop` : 가장 최근 stash를 적용하고 stash 목록에서 삭제한다.

## Git Tag
1. Annotated Tag : 한 번 만들어지면 변경할 수 없지만, 메시지를 추가할 수 있다. (기본적으로 Annotated Tag를 사용한다.)
	- `git tag -a <tag name> -m <message>` : Annotated Tag를 생성한다.
	- `git show <tag name>` : Tag 정보를 확인한다.
2. Lightweight Tag : 변경할 수 있지만, 메시지를 추가할 수 없다.
	- `git tag <tag name>` : Lightweight Tag를 생성한다.
	- `git show <tag name>` : Tag 정보를 확인한다.

- `git tag` : Tag 목록을 확인한다.
- `git tag -d <tag name>` : Tag를 삭제한다.
- `git show <tag name>` : Tag 정보를 확인한다.
- `git push origin <tag name>` : Tag를 원격 저장소로 전송한다.
- `git push origin --tags` : 모든 Tag를 원격 저장소로 전송한다.
