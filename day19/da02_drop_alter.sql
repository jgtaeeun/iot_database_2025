
-- alter
-- 3.37 NewBook 테이블에 varchar(13) isbn속성 추가
ALTER TABLE NewBook ADD isbn VARCHAR(13);

-- 3.38 타입변경
ALTER TABLE NewBook MODIFY isbn INTEGER;

-- 3.39 속성 삭제
ALTER TABLE NewBook DROP COLUMN isbn;

-- 3.40 bookname속성 not null 로 변경
-- NewBook 테이블에 publisher값을 null로 가진 행이 있을 경우, 1138:invalid use of null value
ALTER TABLE NewBook MODIFY publisher VARCHAR(255) NOT NULL;

-- 3.42  newbook 테이블 삭제
-- 자식테이블이 있을 경우, 3730:Cannot drop table reference ...
-- 자식테이블 선삭제, 부모테이블 후삭제
DROP TABLE NewOrders;
DROP TABLE NewBook;
DROP TABLE NewCustomer;