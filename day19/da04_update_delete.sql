-- UPDATE
-- 3-47 Customer 테이블에서 고객번호가 5인 고객의 주소를 대한민국 부산으로 변경 
SELECT * FROM Customer;

UPDATE Customer SET address = '대한민국 부산' WHERE custid = 5 ;

-- 3-48  Book 테이블에서 14번 의 출판사를 imported_book의 21번의 출판사와 동일하게 변경
SELECT * FROM Book;
SELECT * FROM Imported_Book WHERE bookid =21 ;

UPDATE Book SET publisher = (SELECT publisher FROM Imported_Book WHERE bookid =21) 
WHERE bookid = 14;

-- 추가 . 데이터 수정시 조심할 것! where절 필요!!
SELECT *
  FROM NewBook;

UPDATE NewBook SET price = 100000 
WHERE bookid = 3;

-- 3.49 Book 테이블에서 도서번호가 11인 도서를 삭제하시오
SELECT * FROM Book;
DELETE FROM Book WHERE bookid =11;

-- .3.50 Newbook 전체 행 삭제
SELECT * FROM NewBook;
DELETE FROM NewBook;