-- 데이터베이스 생성
CREATE DATABASE sample;

-- 데이터베이스 생성 (CharSet, Collation 지정)
CREATE DATABASE sample2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 변경
ALTER DATABASE sample
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 삭제
-- 운영DB에서 DROP 하면 안됨!!!!
DROP DATABASE sample2;
DROP DATABASE sample;

-- 테이블 생성
-- 쿼리 3-34 NewBook 테이블 생성. 정수형은 INTEGER , 문자형은 VARCHAR
-- 기본키가 1개 또는 2개이상일 경우,
CREATE TABLE NewBook (
	bookId INTEGER,
    bookName VARCHAR(255),
    publisher VARCHAR(255),
    price INTEGER,
    PRIMARY KEY (bookId)
);
-- 기본키가 하나면 컬럼 하나에 작성 가능. 
-- 기본키가 2개이상일 경우, 컬럼에 PRIMARY KEY를 두군데 이상 작성 불가
CREATE TABLE NewBook (
	bookId INTEGER PRIMARY KEY,
    bookName VARCHAR(255),
    publisher VARCHAR(255),
    price INTEGER
);

DROP TABLE NewBook;

-- 테이블 생성시,제약조건
-- bookName은 NOT NULL,
-- publisher은 같은 값이 있으면 안된다.
-- price는 값이 입력없을 경우, 기본값 10000원
-- 최소가격은 1000원이상

CREATE TABLE NewBook (
	bookId INTEGER ,
    bookName VARCHAR(255) NOT NULL,
    publisher VARCHAR(255) UNIQUE,
    price INTEGER DEFAULT 10000 CHECK (price >=1000),
    PRIMARY KEY (bookId)
);

-- 쿼리 3-35 
CREATE TABLE NewCustomer(
	custid  INTEGER,
    name 	VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone   VARCHAR(30) NOT NULL,
    PRIMARY KEY (custid)


);
-- 쿼리 3-36 
-- custid , bookid는 외래키
CREATE TABLE NewOrders(
	orderid INTEGER ,
    custid  INTEGER NOT NULL,
    bookid  INTEGER NOT NULL, 
    saleprice INTEGER, 
    orderdate DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
    FOREIGN KEY (bookid) REFERENCES Book (bookid) ON DELETE CASCADE
);