-- 3-44 Book 테이블에 스포츠 의학을 삽입하시오
-- 한솔의학서적, 90000
SELECT * FROM Book;
INSERT INTO Book(bookid, bookname, publisher, price) Values (13, '스포츠 의학', '한솔의학서적', 9000);
SELECT * FROM Book;

-- 컬럼명 생략
INSERT INTO Book Values (14, '해커스토익보카', '해커스', 10000);
SELECT * FROM Book;


-- 다중데이터 입력
INSERT INTO Book (bookid, bookname, publisher, price) 
Values (15, '스포츠 의학', '한솔의학서적', 9000),
		(16, '스포츠 의학', '한솔의학서적', 9000);
        
SELECT * FROM Book;

-- 3-46 수입도서 목록(Imported_Book)을 Book테이블에 모두 삽입하시오
-- 한 테이블에 있는 많은 데이터를 다른 테이블로 복사하는데 가장 효과적인 방법
SELECT * FROM Imported_Book;

INSERT INTO Book(bookid, bookname, publisher, price)  
SELECT bookid, bookname, publisher, price FROM Imported_Book;
SELECT * FROM Book;

-- 추가. 테이블의 숫자형 타입으로 된 pk값이 자동으로 증가하도록 만들고 사용하려면  AUTO_INCREMENT
CREATE TABLE NewBook(
	bookid 		INTEGER PRIMARY KEY AUTO_INCREMENT,
    bookname 	VARCHAR(50) NOT NULL, 
    publisher 	VARCHAR(50) NOT NULL, 
    price 		INTEGER NULL -- NULL은 생략 가능
);

INSERT INTO NewBook ( bookname, publisher, price) VALUES ('스포츠 의학', '한솔의학서적', 90000);
INSERT INTO NewBook ( bookname, publisher, price) VALUES ('스포츠 의학', '한솔의학서적', 90000);

SELECT * FROM NewBook;

-- AUTO_INCREMENT의 경우, 삭제한 번호를 재사용할 수 없다. 
-- AUTO_INCREMENT의 경우, INSERT 시 코드에 기입하지 않음
DELETE FROM NewBook WHERE bookid= 2;
SELECT * FROM NewBook;
INSERT INTO NewBook ( bookname, publisher, price) VALUES ('스포츠 의학', '한솔의학서적', 90000);
SELECT * FROM NewBook;