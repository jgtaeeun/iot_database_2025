-- 잘못 설계된 계절학기 수강 테이블

-- 7.1 계절학기 테이블
DROP TABLE IF EXISTS Summer; -- 기존 Summer테이블 삭제

-- 계절학기 테이블 생성
CREATE TABLE Summer(
	sid INTEGER,
    class VARCHAR(20),
    price INTEGER
);



-- 기본 데이터 추가
INSERT INTO Summer VALUES (100, 'JAVA' , 20000);
INSERT INTO Summer VALUES (150 , 'Python' , 15000) , (200, 'C' , 10000),(250, 'JAVA' , 20000);


SELECT * FROM Summer;

-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
SELECT sid, class 
  FROM Summer;
  
-- C강좌의 수강료는?
SELECT price 
  FROM Summer
 WHERE class LIKE '%C%';
 
 -- 수강료가 비싼 과목은?
 SELECT DISTINCT class
	FROM Summer
 WHERE price =( SELECT  max(price) FROM Summer);
 
 -- 계절학기를 듣는 학생 수와 수강료 총액은?
 SELECT COUNT(*) AS '학생 수' , SUM(price) AS '수강료 총액'
  FROM Summer;
  
  
  /*이상현상*/
  -- 삭제이상
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Summer WHERE sid=200; 
SET SQL_SAFE_UPDATES = 1;

SELECT price
  FROM Summer
 WHERE class LIKE '%C%';
 
 -- 삽입이상
 INSERT INTO Summer VALUES (NULL, 'C++', 25000);
 SELECT COUNT(*) FROM Summer;
 SELECT COUNT(sid) FROM Summer;
 
 -- 수정이상
 -- JAVA의 가격이 일치하지 않음
 SET SQL_SAFE_UPDATES = 0;
 UPDATE Summer SET price=15000 WHERE sid=100;
 SET SQL_SAFE_UPDATES = 1;
 
 -- 이상현상 테이블 데이터 삭제
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Summer;
SET SQL_SAFE_UPDATES = 1;


