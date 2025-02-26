-- 조인
SELECT * 
  FROM Customer
 INNER JOIN Orders
    ON Customer.custid = Orders.custid;
    
-- 생략형 쿼리
SELECT * 
  FROM Customer , Orders
 WHERE Customer.custid = Orders.custid;
 
 -- 중복되거나 필요없는 컬럼은 제거하고 출력
 -- 쿼리 3-21 고객과 고객의 주문에 대한 데이터를 모두 나타내시오
 SELECT Customer.custid
	  , Customer.name
      , Customer.address
      , Orders.orderid
      , Orders.bookid
      , Orders.saleprice
      , Orders.orderdate
  FROM Customer , Orders
 WHERE Customer.custid = Orders.custid;
 
 -- 테이블명을 줄여서 별명으로 사용
  SELECT c.custid
	  , c.name
      , c.address
      , o.orderid
      , o.saleprice
      , o.orderdate
  FROM Customer AS c , Orders AS o
 WHERE c.custid = o.custid;
 
 -- 필요하면 테이블 또 조인함
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
       
-- 쿼리 3-22 고객과 고객의 주문에 관한 데이터를 고객명로 정렬
  SELECT c.custid
	  , c.name
      , c.address
      , o.orderid
      , o.saleprice
      , o.orderdate
  FROM Customer AS c , Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.name;       
 
 -- 쿼리3-23 . 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오
SELECT c.name , o.saleprice
  FROM Customer AS c, Orders AS o 
 WHERE c.custid = o.custid;
 
 -- 쿼리 3-24. 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오
SELECT c.name, SUM(o.saleprice)
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid
 ORDER BY c.name;

-- 쿼리 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
SELECT c.name, b.bookname
  FROM Customer AS c, Orders AS o , Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;
 
-- 쿼리 3-26 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오
SELECT c.name, b.bookname
  FROM Customer AS c, Orders AS o , Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid
   AND b.price = 20000;

-- 외부조인 : 조건을 만족하지 않는 데이터도 출력이 필요할 때 사용하는 조인
-- LEFT OUTER JOIN, RIGHT OUTER JOIN

-- 쿼리 3-27 도서를 구매하지 않은 고객을 포함해 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오 
SELECT c.name, o.saleprice
  FROM Customer AS c
  LEFT JOIN Orders AS o 
    ON c.custid = o.custid;
    
SELECT c.name, o.saleprice
  FROM Customer AS c
  RIGHT JOIN Orders AS o 
    ON c.custid = o.custid; 
    
    
 -- 서브쿼리 (부속질의)
 SELECT MAX(price)
   FROM Book;
   
SELECT bookname
  FROM Book
  WHERE price = 35000;

-- 쿼리 3-28 가장비싼 도서의 이름을 나타내시오      
SELECT bookname
  FROM Book
 WHERE price = (
	SELECT MAX(price) 
	  FROM Book);
      
-- 쿼리 3-29  도서를 구매한 적이 있는 고객의 이름을 검색하시오
SELECT name
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);
      

-- 쿼리 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 나타내시오
SELECT name
  FROM Customer 
 WHERE custid IN (
				SELECT DISTINCT custid 
				  FROM Orders 
				 WHERE bookid  IN (
										SELECT bookid 
                                          FROM Book 
										 WHERE publisher= '대한미디어')
				); 
SELECT c.name
  FROM Customer AS c , Orders AS o, Book AS b
 WHERE c.custid = o.custid 
   AND b.bookid = o.bookid
   AND b.publisher = '대한미디어';

   -- 쿼리 3-31 출반사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
	-- 상관 서브쿼리
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
									
 

-- 집합연산
SELECT name
  FROM Customer
 UNION
SELECT bookname
  FROM Book;
 
 -- 타입에 제약이 없음
SELECT name
  FROM Customer
 UNION
SELECT orderdate
  FROM Orders;
  
  -- EXISTS : 상관서브쿼리에서 사용하는 키워드. 상관서브쿼리가 아니라도 사용가능
  -- 주문이 있는 고객의 이름과 주소를 나타내시오
  SELECT name, address
    FROM Customer AS c
   WHERE EXISTS (
		SELECT o.custid 
          FROM Orders AS o
		 WHERE o.custid = c.custid
   );