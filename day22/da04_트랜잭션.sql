-- 트랜잭션

-- 테이블 생성
CREATE TABLE Bank(
	name VARCHAR(40),
    balance INTEGER,
    PRIMARY KEY (name)

);

-- 기본 데이터 추가
INSERT INTO Bank VALUES ('박지성', 1000000),('김연아',1000000);


-- 트랜잭션
-- 트랜잭션 시작 START TRANSACTION;
-- 성공 시 COMMIT;
-- 실패 시 ROLLBACK;

START TRANSACTION;
-- 계좌 읽어온다.
SELECT * FROM Bank WHERE name ='박지성';
SELECT * FROM Bank WHERE name ='김연아';

-- 박지성 계좌에서 10000원 인출
UPDATE Bank  SET balance = balance - 10000 WHERE  name ='박지성';
-- 박지성 계좌에서 10000원 입금
UPDATE Bank  SET balance = balance + 10000 WHERE  name ='김연아';

SELECT * FROM Bank WHERE name ='박지성';
SELECT * FROM Bank WHERE name ='김연아';
-- 트랜잭션 종료
COMMIT;
ROLLBACK;