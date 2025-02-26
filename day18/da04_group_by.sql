-- 쿼리3-15 : 고객이 주문한 도서의 총판매액을 구하시오
SELECT SUM(saleprice) AS 총판매액
  FROM Orders;

-- 쿼리 3-16 : 2번 김연아 고객이 주문한 도서의 총 판매액
SELECT SUM(saleprice)  AS 총판매액
  FROM Orders
 WHERE custid = 2;

-- 쿼리 3-18 : 마당서점의 도서 판매 건수를 구하시오
SELECT COUNT(*)
  FROM Orders;

-- 쿼리 3-17: 고객이 주문한 도서의 총판매액, 평균값, 최저가 , 최고가를 구하시오
SELECT SUM(saleprice) AS 총판매액
	 , AVG(saleprice) AS 평균값
     , MIN(saleprice)  AS 최저가 
     , MAX(saleprice)  AS 최고가 
     , STD(saleprice) AS 표준편차
  FROM Orders;
  
-- 번외  
SELECT COUNT(custid)
  FROM Orders ;
  
-- 그룹화 GROUP BY
--  GROUP BY 를 사용하면 반드시 집계함수를 SELECT 안에 포함시켜야 함
-- 쿼리 3-19 고객별로 주문한 도서의 총수량과 총판매액을 구하시오
SELECT custid
	 , count(*) AS 주문수량
	 , SUM(saleprice) AS 총판매액
  FROM Orders
 GROUP BY custid;
 
-- 쿼리 3-19에서 고객별총액을 내림차순으로 출력하시오
 SELECT custid
	 , count(*) AS 주문수량
	 , SUM(saleprice) AS 총판매액
  FROM Orders
 GROUP BY custid
 ORDER BY 3 DESC;
 
SELECT custid
	 , count(*) AS 주문수량
	 , SUM(saleprice) AS 총판매액
  FROM Orders
 GROUP BY custid
 ORDER BY 총판매액 DESC;
 
 -- 쿼리 3-20 : 가격이 8000원이상인 도서를 구매한 고객에 대하여 고객별 주문도서의 총수량을 구하시오.
-- 단 , 2권이상 구매한 고객에 대해서만 한정
-- COUNT() 등 집계함수는 WHERE절에 넣을 수 없음

SELECT custid
	 ,COUNT(*) AS 총수량
  FROM Orders
 WHERE saleprice >=8000 
 GROUP BY custid
 HAVING 총수량 >=2;
 
 
 -- 추가
 SELECT custid
	 , count(*) AS 주문수량
	 , SUM(saleprice) AS 총판매액
  FROM Orders
 GROUP BY custid
 WITH ROLLUP;
 