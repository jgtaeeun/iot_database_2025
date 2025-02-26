-- 쿼리 3-12 : 도서를 이름순(오름차순)으로 검색하시오

SELECT *
  FROM Book
 ORDER BY bookname ASC;
  
-- 번외
SELECT *
  FROM Book
 ORDER BY bookname DESC;
 
 -- 쿼리 3-13 : 도서를 가격순으로 검색하고 , 가격이 같으면 이름순으로 검색하시오
SELECT *
  FROM Book
 ORDER BY price , bookname;
 
-- 쿼리 3-14 : 도서를 가격의 내림차순으로 검색하시오. 가격이 같다면 출판사를 오름차순으로 출력하시오
SELECT *
  FROM Book
 ORDER BY price DESC, publisher ;
 
 
  