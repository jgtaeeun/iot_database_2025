CREATE TABLE SummerPrice(
	class VARCHAR(20),
    price integer
);

INSERT INTO SummerPrice VALUES ('JAVA',20000),('PYTHON',15000),('C',10000);

CREATE TABLE SummerEnroll(
	
    sid integer ,
    class VARCHAR(20)
);


INSERT INTO SummerEnroll VALUES (100,'JAVA'),(150,'PYTHON'),(200,'C'),(250,'JAVA');

SELECT *
 FROM SummerPrice;
 
 SELECT *
  FROM SummerEnroll;
  
  -- 삭제이상 없음
  SET SQL_SAFE_UPDATES = 0;
  DELETE FROM SummerEnroll WHERE sid = 200;
    SET SQL_SAFE_UPDATES = 1;
    
    -- 삽입 이상 없음
	INSERT INTO SummerPrice VALUES ('C#',25000);
    
    -- 수정이상 없음
      SET SQL_SAFE_UPDATES = 0;
    UPDATE SummerPrice SET price = 13000 WHERE class LIKE '%C%';
     SET SQL_SAFE_UPDATES = 1;