-- 특정 물고기를 잡은 총 수 구하기
-- 서브쿼리
SELECT COUNT(*) AS 'FISH_COUNT'
 FROM FISH_INFO
 WHERE FISH_TYPE IN (SELECT FISH_TYPE FROM FISH_NAME_INFO WHERE FISH_NAME IN ('BASS','SNAPPER'))
 ;
 
 -- 내부조인
 SELECT COUNT(*) AS FISH_COUNT
 FROM FISH_INFO 
 JOIN FISH_NAME_INFO
 ON FISH_INFO.FISH_TYPE = FISH_NAME_INFO.FISH_TYPE 
 WHERE FISH_NAME_INFO.FISH_NAME IN ('BASS' , 'SNAPPER');