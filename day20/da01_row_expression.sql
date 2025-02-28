-- 4.11 고객목록에서 고객번호, 이름, 전번을 앞의 2명만 출력하시오
SET @seq := 0 ; -- 변수선언: SET으로 시작하고 @를 붙임. 값할당은 := 임

SELECT (@seq := @seq +1 ) AS '행번호'
	, custid
    , name
    , phone
  FROM Customer
 WHERE @seq <2 ;
 
 SET @seq := 0 ;
 SELECT
	(@seq := @seq +1 ) AS '행번호'
	,custid
    , name
    , phone
  FROM Customer
 LIMIT 2;


-- 특정범위 추출 (3번쩨행 다음행부터 2개를 추출)
 SELECT
	custid
    , name
    , phone
  FROM Customer
 LIMIT 2 OFFSET 3;