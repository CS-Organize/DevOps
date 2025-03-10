# [Action](https://docs.github.com/en/actions)

GitHub Actions는 빌드, 테스트 및 배포 파이프라인을 자동화할 수 있는 CI/CD(지속적 통합 및 지속적 전달) 플랫폼입니다. \
리포지토리에 대한 모든 풀 요청을 빌드 및 테스트하거나 병합된 풀 요청을 프로덕션에 배포하는 워크플로를 생성할 수 있습니다.

```yml
trigger: event

workflow
└── job (in same runner)
    └── step
        └── action
```

## Workflow

워크플로는 하나 이상의 `Job`을 실행하는 구성 가능한 자동화된 프로세스입니다. YAML 파일로 정의되며 리포지토리에 포함됩니다. 워크플로는 특정 이벤트에 의해 자동으로 트리거되거나, 수동으로 또는 예약된 일정에 따라 실행될 수 있습니다.

```yml
name: Example Workflow

on: [push] # event

jobs:
  build:
    runs-on: ubuntu-latest # runner

    steps: # job
      - name: Check out code
        uses: actions/checkout@v2 # action

      - name: Run a one-line script
        run: echo "Hello, world!"
```

## Event

이벤트는 워크플로 실행을 트리거하는 리포지토리에서 발생하는 특정 활동입니다. 예를 들어, 누군가 **Pull Request**을 생성하거나, **Issue**를 열거나, 리포지토리에 커밋을 **Push**할 때 이벤트가 발생할 수 있습니다. 이 이벤트는 정의된 워크플로를 자동으로 실행하게 만듭니다.

## Job

작업은 동일한 `Runner`에서 실행되는 `Step`의 집합입니다. 각 단계는 셸 스크립트를 실행하거나, 특정 작업을 호출하는 등의 작업을 수행합니다. 모든 단계는 순차적으로 실행되며, 동일한 실행기에서 실행되기 때문에 데이터나 환경을 공유할 수 있습니다.

## Actions

`Action`은 복잡하지만 자주 반복되는 작업을 수행하는 GitHub Actions 플랫폼용 사용자 지정 애플리케이션입니다. 예를 들어, 코드 리포지토리를 체크아웃하거나, 빌드 환경을 설정하는 등의 작업을 자동화할 수 있습니다. `Action`을 사용하면 워크플로 파일 내에서 반복적으로 작성해야 하는 코드를 줄일 수 있습니다.

## Runner

`Runner`는 워크플로가 트리거될 때 실제로 이를 실행하는 서버입니다. GitHub에서 제공하는 기본 `Runner`는 Ubuntu Linux, Microsoft Windows, macOS 환경에서 사용할 수 있습니다. 각 워크플로 실행은 새로 프로비저닝된 가상 머신에서 독립적으로 실행되며, 한 번에 하나의 작업만 처리할 수 있습니다.
