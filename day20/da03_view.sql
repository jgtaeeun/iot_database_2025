-- VIEW
-- DDL CREATE  뷰를 생성
CREATE VIEW v_orders 
	AS
SELECT o.orderid 
	,c.custid
    , c.name
    , b.bookid
    , b.bookname
    , b.price
    , o.saleprice
    , o.orderdate
  FROM Customer AS c , Book AS b , Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;

--  뷰실행
-- SQL 테이블로 할 수 있는 쿼리는 다 실행가능
SELECT *
  FROM v_orders
 WHERE name = '장미란';
 
 -- 4.20 주소에 대한민국을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오
CREATE VIEW v_customer 
	AS 
 SELECT *
   FROM Customer
 WHERE address  LIKE '%대한민국%' ;
 
 SELECT *
   FROM v_customer;
   
   -- 추가 : 뷰로 insert할 수 있음! UPDATE, DELETE도 가능
   -- 단, 뷰의 테이블이 하나여야함.조인된 경우, 안됨/
INSERT INTO v_customer VALUES (7, '손흥민','대한민국 서울', '010-9999-9900');

DROP VIEW v_customer;