-- COALESCE(COUNT(c.PARENT_ID), 0)는 c.PARENT_ID의 NULL이 아닌 값의 개수를 세고,
--  만약 그 값이 NULL이라면 0을 반환하는 구조입니다.
-- 셀프조인
SELECT p.ID, COALESCE(COUNT(c.PARENT_ID) ,0 ) AS CHILD_COUNT
FROM ECOLI_DATA p
LEFT join ECOLI_DATA c
ON p.ID = c.PARENT_ID
group by p.ID
ORDER by p.ID;
