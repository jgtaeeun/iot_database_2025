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
- SQL 개요
    - 데이터베이스에 있는 데이터 추출 및 처리작업을 위해서 사용되는 프로그래밍언어
    - 일반프로그래밍언어와 차이점
        - DB에서만 문제해결 가능
        - 입출력을 모두 DB에서 테이블로 처리
        - 컴파일 및 실행은 DBMS가 수행

- SQL 기초  [SQL](./day18/da01_select.sql)
    - 주석(-- ), 실행(ctrl + enter) 
    - `SELECT *  ALL의 의미.모든 열`
    - SQL문은 세미클론(;)과 함께 끝난다. 그러나 생략해도 된다.(C, Python 같은 코드로 가져갈 때는 반드시 삭제!)
    - 대소문자의 구분은 없지만 SQL 예약어는 대문자로, 테이블이나 속성 이름은 소문자로 적어줌
    - `MySQL에서 문자열은 홑따옴표' 사용`
    - `SELECT * FROM 테이블명 한 후, 열이름을 자동완성으로 작성하여 오타 줄인다.`

    - 데이터 조작어 - 검색(SELECT) , 삽입(INSERT) , 삭제(DELETE) , 수정(UPDATE)
    - 데이터 정의어 - CREATE, ALTER, DROP
    - 데이터 제어어 - GRANT, REVOKE

- SQL 기초 >데이터 조작어- 검색(SELECT)
    ```sql
    --SELECT 기본문법
    SELECT [ALL|DISTINCT] 컬럼명(들)
      FROM 테이블명(들)
     [WHERE 검색조건(들)]
     [GROUP BY 속성이름(들)]
     [HAVING 집계함수검색조건(들)]
     [ORDER BY 속성이름(들) [ASC|DESC]]
     [WITH ROLLUP] 
    ```
    - WHERE [SQL](./day18/da02_where.sql)
        - 비교 : = , <> , !=
            - price BETWEEN 10 AND 20 ;
        - 범위 : BETWEEN
            - price BETWEEN 10 AND 20 ;
        - 집합 : IN , NOT IN
        - 패턴 : LIKE
            - % : 0개이상의 문자열과 일치
            - _ : 1개의 문자와 일치



            - [] : 1개의 문자와 일치
            - [^] : 1개의 문자와 불일치
            - LIKE 연산자에서 [0-1]%와 같은 패턴을 사용하는 것은 MySQL에서 지원되지 않습니다. 
                ```sql
                SELECT *
                  FROM Book
                 WHERE bookname  REGEXP  '[0-1]%'
                ```
        - NULL : IS NULL, IS NOT NULL
        - 복합조건 : AND, OR, NOT 

 
    - ORDER BY [SQL](./day18/da03_order_by.sql)
        - ASC (기본값)
        - DESC
        - 오름차순 : 숫자, 알파벳 대문자, 알파벳 소문자, 한글(ㄱ-ㅎ)    

    - 집계함수  [SQL](./day18/da04_group_by.sql)
        - AS : 별칭 ,` 공백이 포함될 경우 작은따옴표로 묶기 (예) ' 평균 주문금액' (O) 평균 주문금액(X)`
        - SUM(속성이름) AS 합계
        - COUNT (속성이름| *)
            - ` NULL 값을 제외한 해당 속성의 투플 개수`
            - `COUNT(*) 전체 튜플의 수`
        - AVG(속성이름)
        - MAX
        - MIN
        - STD

    - GROUP BY [SQL](./day18/da04_group_by.sql)
        - 반드시 집계함수를 SELECT 안에 포함시켜야 함
        - `GROUP BY custid 일때, SELECT 에는 custid, 그외 나머지컬럼은 집계함수로 표현`
        - WHERE절, GROUP BY, HAVING절 순서이다.
        - `WITH ROLLUP `
           
            ```sql
            -- 고객별 주문수량, 총판매액 출력하고 , 전체를 합산하여 통계를 표시하세요
            SELECT custid
                  , count(*) AS 주문수량
                  , SUM(saleprice) AS 총판매액
              FROM Orders
             GROUP BY custid
             WITH ROLLUP;
            ```
    - 별칭을 이용하는 경우,
        ```sql
            SELECT custid
                , count(*) AS 주문수량
                , SUM(saleprice) AS 총판매액
            FROM Orders
            GROUP BY custid
            ORDER BY 총판매액 DESC;
        ```
    - 조인 
        - WHERE 부모테이블.기본키 = 자식테이블.외래키
        - INNER JOIN
            ```sql
                 SELECT c.custid
                    , c.name
                    , c.address
                    , o.orderid
                    , o.saleprice
                    , o.orderdate
                    , b.bookname
                    , b.publisher
                    , b.price
                FROM Customer AS c , Orders AS o , Book AS b
                WHERE c.custid = o.custid 
                    AND b.bookid = o.bookid;
            ```
        - OUTER JOIN
            - LEFT OUTER JOIN 또는 RIGHT OUTER JOIN - LEFT, RIGHT는 기준이 되는 테이블의 위치이며, 주로 부모테이블이 기준이 된다.
            ```sql
            SELECT c.name, o.saleprice
              FROM Customer AS c
              LEFT JOIN Orders AS o 
                ON c.custid = o.custid
            ```

        - 서브쿼리(부속질의) [SQL](./day18/da05_query.sql)
        ```sql
        -- 서브쿼리 <-> 조인
        -- 서브 쿼리
        SELECT name FROM Customer WHERE custid IN (  SELECT DISTINCT custid FROM Orders WHERE bookid IN ( SELECT bookid FROM Book WHERE publisher = '대한미디어' )) ;
        -- 내부조인
        SELECT c.name 
          FROM Customer AS c , Orders AS o, Book AS b 
         WHERE c.custid = o.custid 
           AND b.bookid = o.bookid
           AND b.publisher ='대한미디어';
        ```

        - 상관 서브쿼리
        ```sql
        -- 쿼리 3-31 출반사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
        SELECT b2.publisher 
             , AVG(b2.price)
         FROM Book AS b2
        GROUP BY b2.publisher;
        
        SELECT b1.bookname
          FROM Book AS b1
         WHERE  b1.price > (
                            SELECT AVG(b2.price)
                              FROM Book AS b2
                             WHERE b2.publisher = b1.publisher
                            );
									
        ```

        - EXISTS : 상관서브쿼리에서 사용하는 키워드. 상관서브쿼리가 아니라도 사용가능
        ```sql
         SELECT name, address
           FROM Customer AS c
          WHERE EXISTS (
                    SELECT o.custid 
                      FROM Orders AS o
                     WHERE o.custid = c.custid
            );
        ```

## 19일차 : 2월 27일
- Visual Studio Code에서 MySQL 연동
    - 확장 > MySQL 검색
        1. Weijan Chen 개인개발자가 만든 Database Client (강력 추천-모든 데이터베이스 서버타입 다 가능)
            - 왼쪽 툴바에 database, nosql 아이콘 생성됨
            - database 아이콘 - > create connection -> connect and save
            <img src='./images/database_connection.png' width=600>
            <img src='./images/database_use.png' width=600>
        2. Weijan Chen 개인개발자가 만든 MySQL 확장 
        3. Oracle에서 개발한 MySQL Shell for VS Code 
            - 왼쪽 툴바에 돌고래 아이콘 생성됨
            - MySQL Shell에서 위자드 Next -> 인증서 설치 -> VS Code 재시작 - > workbench 첫화면과 동일한 화면 나타남
            - new connection
             <img src='./images/mysql_shell_connection.png' width=600>

- SQL 기초
    - 기본 데이터형
        - 데이터베이스에는 엄청 많은 데이터형이 존재(데이터 사이즈 저장용량을 절약하기 위해서)
        - 주요 데이터형
            - SmallInt(2byte) - 65535가지 수(음수포함)(-32768~32767)
            - Int(byte) -42억 정수(음수)
            - BigInt(8byte) 
            - Float(4byte) - 소수점아래 7자리까지 저장
            - Decimal(5~17byte) - Float보다 더 큰 수 저장
            - `Char(n) - n은 가변(1~255). 고정길이 문자열`
                - `주의점! 글자 입력시, Char(10)에 Hello 글자를 입력하면 'Hello     '`
            - ` Varchar(n) - n(1~65535) ,가변길이 문자열`
                - `주의점! 글자 입력시, Varchar(10)에 Hello 글자를 입력하면 'Hello'`
            - Longtext(최대4GB) - 뉴스나 영화스크립트 저장
            - LongBlob(최대4GB) - mp3, mp4음악, 영화데이터 자체 저장
            - Date(3) - 2025-02-27 까지 저장
            - DateTime(8) - 2025-02-27 10:46:34까지 저장
            - JSON(8) - json 타입

- SQL 기초>데이터 정의어 - CREATE, ALTER, DROP
    - 테이블 생성 후 확인 - DATABASE탭 -> REVERSE Engineer
    <img src='./images/EER_Diagram.png' width=500>

    - DROP
        - `DROP 은 매우 위험하니 사용 금지!!`
        - 외래키로 연결되어 있을 경우
            - `부모테이블 선삭제일 때,  3730:Cannot drop table reference ...`
            - `자식테이블 선삭제, 부모테이블 후삭제`
            ```sql
            DROP TABLE NewOrders;
            DROP TABLE NewBook;
            ```
    - CREATE [SQL](./day19/da01_create.sql)
        - DATABASE
        - TABLE 
            - 속성 데이터형 ,기본키 , 제약조건(NOT NULL, UNIQUE, DEFAULT, CHECK) , 외래키
            ```sql
            -- 기본키가 1개 또는 2개이상일 경우,
            CREATE TABLE NewBook (
                bookId    INTEGER ,
                bookName  VARCHAR(255) NOT NULL,
                publisher VARCHAR(255) UNIQUE,
                price     INTEGER DEFAULT 10000 CHECK (price >=1000),
                PRIMARY KEY (bookId)
            );
            -- 기본키가 하나면 컬럼 하나에 작성 가능. 
            -- 기본키가 2개이상일 경우, 컬럼에 PRIMARY KEY를 두군데 이상 작성 불가
            CREATE TABLE NewCustomer(
            custid  INTEGER PRIMARY KEY ,
            name 	VARCHAR(100) NOT NULL,
            address VARCHAR(255) NOT NULL,
            phone   VARCHAR(30) NOT NULL
            );
            ```
            ```sql
            CREATE TABLE NewOrders(
            orderid INTEGER ,
            custid  INTEGER NOT NULL,
            bookid  INTEGER NOT NULL, 
            saleprice INTEGER, 
            orderdate DATE,
            PRIMARY KEY (orderid),
            FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
            FOREIGN KEY (bookid) REFERENCES NewBook (bookId) ON DELETE CASCADE
            );
            ```
    - ALTER [SQL](./day19/da02_drop_alter.sql)
        - ADD, MODIFY, DROP
        ```sql
        ALTER TABLE NewBook ADD isbn VARCHAR(13);

        ALTER TABLE NewBook MODIFY isbn INTEGER;

        ALTER TABLE NewBook DROP COLUMN isbn;

        -- NewBook 테이블에 publisher값을 null로 가진 행이 있을 경우, 1138:invalid use of null value
        ALTER TABLE NewBook MODIFY publisher VARCHAR(255) NOT NULL;
        ```

- SQL 기초> 데이터 조작어-  삽입(INSERT) , 삭제(DELETE) , 수정(UPDATE)
    - AUTO_INCREMENT 
        - INSERT 시 코드에 기입하지 않음
        - 삭제한 번호를 재사용할 수 없다. 

    - INSERT [SQL](./day19/da02_drop_alter.sql)
        - 기본형, 생략형, `다중데이터 입력, 테이블 입력`
    ```sql
    INSERT INTO 테이블명(속성1, 속성2 ..) VALUES (값1, 값2 ...);

    -- 생략형
     INSERT INTO 테이블명 VALUES (값1, 값2 ...);

      -- 다중데이터 입력
     INSERT INTO 테이블명(속성1, 속성2 ..)
      VALUES (값1, 값2 ...),
             (값1, 값2 ...);

    -- 한 테이블에 있는 많은 데이터를 다른 테이블로 복사하는데 가장 효과적인 방법
    INSERT INTO Book(bookid, bookname, publisher, price)  
    SELECT bookid, bookname, publisher, price FROM Imported_Book;
    ```

    - UPDATE [SQL](./day19/da04_update_delete.sql)
        - 우측 톱니바퀴 아이콘 (Show Preference Dialog) - SQL Editor - 제일 아래 Safe Updates (rejects UPDATEs and DELETEs with no restrictions) 체크
            - 1175  You are using safe update mode ... : where절 없이 update 시, 모든 행이 다 적용됨을 경고       
    ```sql
    UPDATE 테이블명 SET 속성 = 값 , 속성 = 값  WHERE 조건;
    ```
    - DELETE 
        - 우측 톱니바퀴 아이콘 (Show Preference Dialog) - SQL Editor - 제일 아래 Safe Updates (rejects UPDATEs and DELETEs with no restrictions) 체크
            - 1175  You are using safe update mode ... : where절 없이 DELETE 시, 모든 행이 다 적용됨을 경고   
     ```sql
    DELETE FROM 테이블명 WHERE 조건 ;
    ```    
- SQL 고급
    - 내장함수
        - 숫자함수 
        ```sql
        SELECT ABS(-78), ABS(+78);
        SELECT ROUND(4.875);	-- 5
        SELECT ROUND(4.875,1); -- 4.9
        ```
        - 문자함수 
            - `replace(문자열, 문자, 문자)는 화면 출력용, 데이터베이스에 값을 변경하려면 UPDATE문 써야함.`
            - `char_length() 문자수 , length() 바이트수` ,  -- utf8에서 한글 한글자의 바이트 수는 3bytes , 공백 바이트 수는 1byte
            - `SUBSTR(문자열, 처음시작 인덱스, 개수)` **DB은 인덱스 1부터**
        ```sql
        -- TRIM
        SELECT CONCAT('--' ,TRIM('     HELLO     '),'--');  -- --HELLO--
        SELECT CONCAT('--' ,LTRIM('     HELLO     '),'--');  -- --HELLO     --
        SELECT CONCAT('--' ,RTRIM('     HELLO     '),'--');  -- --     HELLO--

        SELECT TRIM('=' FROM ' ===HELLO==='); -- ===HELLO
        SELECT TRIM('=' FROM '===HELLO==='); -- HELLO
        ```
        - 날짜, 시간 함수
            - SYSDATE()  -- Docker 서버시간을 따라서 그리니치천문대 시간 기준임 , 한국시간은 +9 해야함
            - ADDDATE(SYSDATE(), INTERVAL 9 HOUR) AS '한국 시간'
            - DATEDIFF(DAY1, DAY2) DAY1-DAY2가 결과로 나옴   
            - 포맷 
                - %Y(4자리 연도) %y(4자리 연도 중 마지막 2자기) %M(월이름 영어 January) %m(01~12) %b(월 약어 Jan) %d(00~31) 
                - %H(00~23시간) %h(01~12시간) %i(0~59) %s(0~59) %p(AM/PM)
                - `1000단위마다 , 넣기`
                ```sql
                 SELECT bookid, bookname, FORMAT(price, 0) AS price
                 FROM Mybook;
                ```
    - NULL 값 처리
        - '0', ''. ' '(공백) 등과 다른 특별한 값
        - IS NULL, IS NOT NULL
        - 집계함수 사용할 때 주의할점 : NULL + 숫자는 NULL이다. Null이 포함된 행은 집계에서 빠진다.(예 - count(*))
        <img src='./images/null값 포함된 테이블.png' width=500>
        <img src='./images/null값숫자연산.png' width=500>
        <img src='./images/널값집계함수.png' width=500>