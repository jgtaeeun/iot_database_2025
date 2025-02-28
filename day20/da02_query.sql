-- 4.12 평균주문금액이하의 주문에 대해서 주문번호와 금액을 나타내시오
SELECT orderid
		, saleprice
  FROM Orders
 WHERE saleprice <= (SELECT AVG(saleprice) FROM Orders);
 
 -- 4-13 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 나타내시오
 SELECT o1.orderid
		, o1.custid
		, o1.saleprice
   FROM Orders o1
 WHERE o1.saleprice > (
		SELECT AVG(saleprice)
          FROM Orders o2
		 WHERE o2.custid = o1.custid
 );
 
 -- 4.14 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
 SELECT SUM(saleprice)
   FROM Orders
 WHERE custid IN (SELECT custid
					FROM Customer
				   WHERE address LIKE '대한민국%');
 
 ;
 
 -- 4.15 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액
 -- 비교연산자만 쓰면 서브쿼리의 값이 단일값이 되어야함.
 SELECT * FROM Orders;
 SELECT orderid
		, saleprice
  FROM Orders
 WHERE saleprice > (
			 SELECT MAX(saleprice)
			   FROM Orders
			  WHERE custid = 3
            ) ;

 -- ALL, SOME, ANY를 쓰게 되면 서브쿼리의 값이 단일값이 아니어도 상관없음
 SELECT orderid
		, saleprice
  FROM Orders
 WHERE saleprice > ALL(
			 SELECT saleprice
			   FROM Orders
			  WHERE custid = 3
            ) ;
            
-- ALL - 서브쿼리 내 결과의 모든 값보다 비교연산이 일치하는 값을 찾는 것
-- SOME, ANY - 서브쿼리 내 결과의 각각의 값보다 비교연산이 일치하는 값을 찾는 것
-- 4-16  EXISTS연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
SELECT SUM(saleprice) AS '총판매액'
  FROM Orders
 WHERE EXISTS (
			SELECT *
			  FROM Customer
			 WHERE address LIKE '대한민국%'
               AND Customer.custid = Orders.custid
 );
 
 -- 추가 최신방법(서브쿼리에서 두가지 컬럼을 비교하는 법) -튜플(파이썬과 동일)
 SELECT *
   FROM Orders 
  WHERE (custid, orderid) IN ( SELECT custid, orderid
								FROM Orders
							   WHERE custid =2
  );
  
  -- 4-17  고객별 판매액을 나타내시오(고객이름, 고객별 판매액 출력하시오)

SELECT o.custid
, (SELECT name FROM Customer WHERE custid = o.custid) -- select 서브쿼리는 스칼라값. 단일행, 단일열
, SUM(o.saleprice)
 FROM Orders o 
 GROUP BY o.custid ;
 -- 4.18 orders테이블에 각 주문에 맞는 도서이름을 입력하시ㅗㅇ
ALTER TABLE Orders ADD bookname VARCHAR(255) ;
SELECT * FROM Orders;
UPDATE Orders  SET bookname = (
				SELECT bookname
                 FROM Book
			    WHERE Book.bookid = Orders.bookid 
) ;
  
 -- from 절 서브쿼리, 인라인뷰
 -- 4.19 고객번호가 2이하인 고객의 판매액을 나타내시오
-- 고객이름과 고객별 판매액 출력
 SELECT custid
		, name
   FROM Customer c
 WHERE custid <=2 ;
 
 -- 가상테이블을 cs라고 이름짓고, from에 넣어줌
 SELECT cs.*
   FROM ( SELECT custid
		, name
   FROM Customer 
 WHERE custid <=2  ) AS cs;
 
  SELECT cs.name, SUM(o.saleprice) AS '구매액'
   FROM ( SELECT custid
				, name
			FROM Customer 
			WHERE custid <=2  ) AS cs , Orders As o
 WHERE cs.custid = o.custid
 GROUP BY  o.custid
 ;
 
 