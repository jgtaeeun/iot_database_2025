
 DROP TABLE IF EXISTS students ;
CREATE TABLE students (
	std_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    std_name VARCHAR(100) NOT NULL,
    std_mobile VARCHAR(20) NULL,  -- 전화번호
    std_regyear INTEGER NOT NULL     -- 입학년도
    
);

-- 더미데이터 추가
INSERT INTO students( std_name , std_mobile,  std_regyear)  VALUES ( '정해성', '010-9999-8888', 2020);

