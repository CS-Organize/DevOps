# Wordpress Container

- [WordPress - Alpine Linux](https://wiki.alpinelinux.org/wiki/WordPress)
- [WordPress Installation](https://www.hostinger.com/tutorials/-how-to-install-wordpress-with-nginx-on-ubuntu/?ppc_campaign=google_search_generic_hosting_all&bidkw=defaultkeyword&lo=1009871)
- [custom-wordpress-docker-setup](https://codingwithmanny.medium.com/custom-wordpress-docker-setup-8851e98e6b8)


php-mysqli와 php-mysqlnd는 PHP에서 MySQL 데이터베이스를 사용하기 위한 확장 모듈입니다. 각각은 MySQL 데이터베이스와의 상호작용을 가능하게 하는 다른 기능과 특성을 가지고 있습니다.

`php-mysqli`와 `php-mysqlnd`는 PHP에서 MySQL 데이터베이스를 사용하기 위한 확장 모듈입니다. 각각은 MySQL 데이터베이스와의 상호작용을 가능하게 하는 다른 기능과 특성을 가지고 있습니다.

### php-mysqli

- `mysqli`는 "MySQL Improved"의 약자입니다. 이 확장은 PHP 5 이상에서 MySQL 데이터베이스를 사용할 때 권장되는 방법입니다.
- `mysqli` 확장은 객체 지향 및 절차적 인터페이스를 모두 제공하여 MySQL 데이터베이스와의 상호작용을 지원합니다.
- 이 확장은 MySQL 4.1 이상에서 도입된 새로운 기능들, 예를 들어, 준비된 문장(prepared statements), 다중 쿼리(multi queries), 트랜잭션(transaction) 등을 지원합니다.

### php-mysqlnd

- `mysqlnd`는 "MySQL Native Driver"의 약자입니다. 이 확장은 PHP 언어에 대한 MySQL 데이터베이스의 기본 드라이버입니다.
- `mysqlnd`는 PHP의 일부로 직접 컴파일되어, PHP 애플리케이션과 MySQL 데이터베이스 간의 통신을 위한 중간 레이어 없이 데이터베이스에 직접 접근할 수 있게 합니다. 이로 인해 성능이 향상되고 메모리 사용이 감소될 수 있습니다.
- `mysqlnd`는 `mysqli`와 PDO_MySQL 확장을 위한 백엔드 드라이버로 사용됩니다. 따라서, 이 드라이버를 사용하면 `mysqli`나 PDO를 통해 MySQL 데이터베이스와 상호작용할 때 내부적으로 `mysqlnd`가 사용됩니다.
- 이 드라이버는 트래픽 분석, 쿼리 캐싱, 및 통계 수집 등의 고급 기능을 제공합니다.

결론적으로, `php-mysqli`는 MySQL 데이터베이스와의 상호작용을 위한 확장이며, `php-mysqlnd`는 PHP와 MySQL 데이터베이스 간의 통신을 위한 기본 드라이버입니다. 두 확장 모두 MySQL 데이터베이스를 사용하는 PHP 애플리케이션 개발에 필수적입니다. 

이런 자료를 참고했어요.
[1] Naver Blog - [php]php mysqlnd mysqli : 네이버 블로그 (https://blog.naver.com/vivacarla/221182674958?viewType=pc)
[2] 웹학교 - MySQL 라이브러리 선택 - PHP 설명서 - 웹학교 (https://php.365ok.co.kr/mysqlinfo.library.choosing.php)
[3] Inpa Dev 👨‍💻 - PHP ↔ MySQL 연결 및 다루기 (mysqli 방식) - Inpa Dev ‍ (https://inpa.tistory.com/entry/PHP-%F0%9F%93%9A-DB-%EB%8B%A4%EB%A3%A8%EA%B8%B0-mysqli-%EB%B0%A9%EC%8B%9D)
[4] jirak.net - PHP 함수의 mysql 데이터베이스 확장 함수의 고찰 (https://jirak.net/wp/php-mysqlnd-mysql-native-driver/) 

뤼튼 사용하러 가기 > https://agent.wrtn.ai/5xb91l
