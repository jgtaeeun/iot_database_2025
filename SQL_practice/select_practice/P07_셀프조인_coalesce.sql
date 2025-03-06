-- COALESCE(COUNT(c.PARENT_ID), 0)는 c.PARENT_ID의 NULL이 아닌 값의 개수를 세고,
--  만약 그 값이 NULL이라면 0을 반환하는 구조입니다.
-- 셀프조인
SELECT p.ID, COALESCE(COUNT(c.PARENT_ID) ,0 ) AS CHILD_COUNT
FROM ECOLI_DATA p
LEFT join ECOLI_DATA c
ON p.ID = c.PARENT_ID
group by p.ID
ORDER by p.ID;

-- 대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력하는 SQL 문을 작성해주세요. 
-- 자식이 없다면 자식의 수는 0으로 출력해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.

SELECT p.ID , COUNT(c.ID) AS CHILD_COUNT
 FROM ECOLI_DATA p
 LEFT JOIN ECOLI_DATA c
 ON p.ID = c.PARENT_ID
 GROUP BY p.ID
 ORDER by p.ID;;
