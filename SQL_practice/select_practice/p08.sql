-- 특정 형질을 가지는 대장균 찾기

-- 2번 형질이 보유하지 않으면서 1번이나 3번 형질을 보유하고 있는 대장균 개체의 수(COUNT)를 출력하는 SQL 문을 작성해주세요. 
-- 1번과 3번 형질을 모두 보유하고 있는 경우도 1번이나 3번 형질을 보유하고 있는 경우에 포함합니다.

Column name     	Type	Nullable
ID	                INTEGER FALSE
PARENT_ID	        INTEGER	TRUE
SIZE_OF_COLONY	    INTEGER	FALSE
DIFFERENTIATION_DATE	DATE	FALSE
GENOTYPE	        INTEGER	FALS

-- 1111   :1,2,3,4
-- 0001 : 1
-- 1000: 4
--  1101 : 1, 3, 4
-- 참고사이트 :https://velog.io/@rina3453/MySQL-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EC%8A%A4-%ED%8A%B9%EC%A0%95-%ED%98%95%EC%A7%88%EC%9D%84-%EA%B0%80%EC%A7%80%EB%8A%94-%EB%8C%80%EC%9E%A5%EA%B7%A0-%EC%B0%BE%EA%B8%B0-LV.1
SELECT COUNT(*)
FROM ECOLI_DATA
WHERE (GENOTYPE & 2 ) =0 AND ( (GENOTYPE&4) >0 OR  (GENOTYPE&1 ) >0 )

