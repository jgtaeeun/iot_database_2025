-- 쿼리 3-1 : 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname, price 
  FROM Book;

-- 쿼리 3-2: 모든 도서의 도서번호, 도서이름 , 출판사, 가격을 검색하시오
SELECT *
  FROM Book;
    
SELECT bookid, bookname, publisher, price
  FROM Book;

-- 쿼리 3-3. 도서 테이블에 있는 모든 출판사를 검색하시오(중복일 경우, 한번만 출력)
-- ALL <-> DISTINCT
SELECT DISTINCT publisher
  FROM Book;
  
-- 쿼리 3-4. 가격이 20000원 미만인 도서를 검색하시오.
SELECT * 
  FROM Book
 WHERE price < 20000;
 
 -- 쿼리3-5. 가격이 10000원 이상 20000원 이하인 도서를 검색하시오
 SELECT *
  FROM Book
 WHERE price >= 10000 AND price <=20000 ;
 
 SELECT *
   FROM Book
 WHERE price BETWEEN 10000 AND 20000;
 
 SELECT *
   FROM Book
 WHERE price !=20000;
 
SELECT *
  FROM Book
 WHERE price <> 20000 ;
 

 -- 쿼리 3-6. 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE publisher IN ('굿스포츠','대한미디어') ;
 
SELECT *
  FROM Book
WHERE publisher = '굿스포츠' 
   OR publisher = '대한미디어';

-- 번외
SELECT *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠','대한미디어');
 
-- 쿼리 3-7. 축구의 역사를 출간한 출판사를 검색하시오
SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '축구의 역사';

-- 번외
-- '축구의'로 시작하는 책제목인 것
SELECT * 
  FROM Book
 WHERE bookname LIKE '축구의%';
 
-- 두번째 글자가 구로 시작하고 / 첫번째글자가 존재함
SELECT *
  FROM Book	
 WHERE bookname LIKE '_구%' ;

SELECT *
  FROM Book
 WHERE bookname  REGEXP  '[^2-3]%';
 
 -- 쿼리 : Customer 테이블에서 phone이 null인 값 찾기
SELECT *
  FROM Customer
 WHERE phone IS  NULL;
 
 -- 쿼리3-10 : 축구에 관한 도서 중 가격이 20000원이상인 도서를 검색하시오
SELECT *
  FROM Book
 where bookname LIKE '%축구%' 
   AND price >= 20000;
   
