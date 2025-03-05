-- DEVELOPERS 테이블에서 Python이나 C# 스킬을 가진 개발자의 정보를 조회하려 합니다. 
-- 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
-- 결과는 ID를 기준으로 오름차순 정렬해 주세요.

-- SKILLCODES 
-- NAME	        CATEGORY	CODE
-- C++	             Back End	4
-- JavaScript	    Front End	16
-- Java	        Back End	128
-- Python	        Back End	256
-- C#	            Back End	1024
-- React	        Front End	2048
-- Vue	            Front End	8192
-- Node.js	        Back End	16384

-- DEVELOPERS
-- ID    FIRST_NAME	LAST_NAME	        EMAIL	            SKILL_CODE
-- D165	Jerami	    Edwards	    jerami_edwards@grepp.co	    400
-- D161	Carsen	    Garza	    carsen_garza@grepp.co	    2048
-- D164	Kelly	    Grant	    kelly_grant@grepp.co	    1024
-- D163	Luka	    Cory	    luka_cory@grepp.co	        16384
-- D162	Cade	    Cunningham	cade_cunningham@grepp.co	8452
-- 참고 사이트 :https://velog.io/@lilixxi/%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EC%8A%A4-sql-%EA%B3%A0%EB%93%9D%EC%A0%90kit-select-%EC%A1%B0%EA%B1%B4%EC%97%90-%EB%A7%9E%EB%8A%94-%EA%B0%9C%EB%B0%9C%EC%9E%90-%EC%B0%BE%EA%B8%B0
SELECT distinct ID, EMAIL, FIRST_NAME, LAST_NAME
 FROM DEVELOPERS d ,SKILLCODES s
 WHERE d.SKILL_CODE & s.CODE = s.CODE 
	AND s.CODE IN (select CODE from SKILLCODES where NAME IN ('Python', 'C#'))
ORDER BY ID;