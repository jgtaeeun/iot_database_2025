# iot_database_2025

## 17일차 : 2월 25일

- MySQL 설치(docker을 통해)
    1. docker 실행 및 로그인 , power shell 오픈, 도커 확인
        ```shell
        >docker -v
        Docker version 27.5.1, build 9f9e405
        ```
    2. MySQL Docker 이미지 다운로드
        ```shell
        >docker pull mysql
        ```
        - `docker desktop - unexpected wsl error 일 경우, window 기능켜기/끄기에서 Hyper-V , Linux용 윈도우 하위 시스템,  가상머신 플랫폼 다 체크하고 다시시작하기`
    3. MySQL  이미지 확인
     ```shell
        >docker images
    ```
    4. docker 컨테이너 생성
    - MySQL Port 3306
    - Oracle Port 1521
    - SQL Server 1433
     ```shell
        >docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:latest 
    ```
    5. 컨테이너 확인
       ```shell
        >docker ps -a 
        ```
    6. docker 컨테이너 시작, 중지, 재시작
       ```shell
        >docker stop mysql-container # 중지
        >docker start mysql-container # 시작
        >docker restart mysql-container # 재시작
        ```
    7. MySQL docker 컨테이너 접속
     ```shell
        >docker exec -it mysql-container bash
        bash-5.1# mysql -u root -p
        12345비번 입력
        mysql >show databases;
        mysql >exit  
        bash-5.1# exit 
        ```
- workbench 설치
    - https://dev.mysql.com/downloads/workbench/ -> goto download ->8.0.41 , Microsoft Windows / Windows (x-86, 32-bit) , MSI installer
    - MySQL Installer에서 workbench(applications 목록에서 찾기)와 samples and examples (documentation 목록에서 찾기) 설치
    - execute 계속 누르기, password 다 생략(취소)하고 설치 
    
- 데이터베이스 시스템
    - 통합된 데이터를 저장해서 운영하면서, 동시에 여러사람이 사용할 수 있도록 하는 시스템
    - 실시간 접근, 계속 변경, 동시 공유가 가능, 내용으로 참조(물리적으로 떨어져 있어도 사용가능)
    
    - DBMS 
        - MySQL, Oracle, SQL Server, MariaDB, MongoDB...
    
- 데이터 베이스 언어
    - SQL(Structured Query Language) : 구조화된 질의 언어(프로그래밍언어와 동일)
        - DDL : Create, Drop, Alter
        - DML : Select, Delete , Update, Insert
        - DCL : Commit, Rollback, Grant, Revoke

- 관계 데이터 모델
    - 3단계 DB 구조 : 외부스키마(실세계와 매핑) -> 개념스키마(DB논리적 설계-데이터와 관계, 제약사항, 무결성 등) -> 내부스키마(물리적 설계- 인덱스, 데이터 레코드의 배치방법, 데이터 압축 등)  -> DB
    
    - 모델에 쓰이는 용어
        - 릴레이션 -테이블과 매핑
        - 속성
        - 튜플
        - 관계

    - 무결성 제약조건
        - 키 - 기본키, 외래키, 슈퍼키, 대체키, 대리키
        - 개체 무결성, 참조 무결성, 도메인 무결성

- SQL 기초
    - SQL 개요
    ```sql
    select publisher, price
    from Book
    where bookname = '축구의 역사';
    ```



## 18일차 : 2월 26일    
- SQL 기초