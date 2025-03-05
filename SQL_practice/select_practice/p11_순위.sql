-- MySQL 8.0 이상에서는 ROW_NUMBER() 윈도우 함수가 도입되었습니다. 이 함수를 사용하면 각 행에 순위를 매길 수 있습니다.
WITH Ranked AS (
    SELECT ID, SIZE_OF_COLONY, ROW_NUMBER() OVER (ORDER BY SIZE_OF_COLONY DESC) AS rank_desc
    FROM ECOLI_DATA
),
RankedWithCount AS (
    SELECT *, (SELECT COUNT(*) FROM ECOLI_DATA) AS total_count
    FROM Ranked
)
SELECT ID,
    CASE 
        WHEN rank_desc <= 0.25 * total_count THEN 'CRITICAL'
        WHEN rank_desc <= 0.5 * total_count THEN 'HIGH'
        WHEN rank_desc <= 0.75 * total_count THEN 'MEDIUM'
        ELSE 'LOW'
    END AS  COLONY_NAME
FROM RankedWithCount
ORDER BY ID;

-- NTILE() 윈도우 함수를 사용하여 SIZE_OF_COLONY 컬럼의 값을 4개의 구간으로 나누고
SELECT ID,
    CASE 
        WHEN SizeRank = 1 THEN 'CRITICAL'
        WHEN SizeRank = 2 THEN 'HIGH'
        WHEN SizeRank = 3 THEN 'MEDIUM'
        WHEN SizeRank = 4 THEN 'LOW'
    END AS COLONY_NAME
FROM 
    (
    SELECT 
        ID,
        SIZE_OF_COLONY,
        NTILE(4) OVER (ORDER BY SIZE_OF_COLONY DESC) AS SizeRank
    FROM 
        ECOLI_DATA
) as RankedColony
ORDER BY ID;
