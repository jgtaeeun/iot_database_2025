-- 부모의 형질을 모두 가지는 대장균 찾기-2

-- 부모의 형질을 모두 보유한 대장균의 ID(ID), 대장균의 형질(GENOTYPE), 부모 대장균의 형질(PARENT_GENOTYPE)을 출력하는 SQL 문을 작성해주세요.
--  이때 결과는 ID에 대해 오름차순 정렬해주세요.

SELECT c.ID , c.GENOTYPE, p.GENOTYPE AS PARENT_GENOTYPE
  FROM ECOLI_DATA p 
LEFT JOIN ECOLI_DATA c
ON p.ID = c.PARENT_ID
WHERE p.GENOTYPE IS NOT NULL AND (p.GENOTYPE & c.GENOTYPE )=p.GENOTYPE 
ORDER BY c.ID