-- 3세대의 대장균의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
-- 이때 결과는 대장균의 ID 에 대해 오름차순 정렬해주세요.


-- 방법1) 서브쿼리
-- 1세대 
select *
from ECOLI_DATA
where PARENT_ID is null;

-- 2세대
select *
from ECOLI_DATA
where PARENT_ID in (
select ID
from ECOLI_DATA
where PARENT_ID is null);

-- 3세대
SELECT *
FROM ECOLI_DATA
WHERE PARENT_ID IN (
	select ID
	from ECOLI_DATA
	where PARENT_ID in (
			select ID
			from ECOLI_DATA
			where PARENT_ID is null)
);

-- 방법2) LEFT JOIN
SELECT s.ID
 FROM ECOLI_DATA p
LEFT JOIN ECOLI_DATA c
ON p.ID = c.PARENT_ID
LEFT JOIN ECOLI_DATA s
ON c.ID = s.PARENT_ID
WHERE s.ID is not null 
 AND p.PARENT_ID is null
ORDER BY s.ID;