-- 단일 행 함수 및 변환 함수

-- 단일 행 함수의 종류
-- 문자조작 - UPPER(), LOWER(), REPLACE(), SUBSTRING(), LTRIM(), CONCAT()

-- 숫자관련 - ROUND(), TRUNCATE(), MOD(), POWER()
-- TRUNCATE()는 MySQL에서 테이블의 모든 데이터를 삭제하는 명령입니다. TRUNCATE는 DELETE와 비슷하게 작동하지만 몇 가지 중요한 차이점이 있습니다.

-- 날짜관련 - SYSDATE(), DATE_ADD(), DATE_SUB(), FROM_DAYS()
-- MySQL의 기준 날짜(0000-01-01)로부터 738919일이 지난 날짜를 계산해 반환합니다.
SELECT FROM_DAYS(738919);

-- 변환함수 - CONVERT(), CAST()
/* CONVERT(expression, type)
expression은 변환할 값입니다.
type은 변환하려는 데이터 타입입니다. 예를 들어, CHAR, DATE, DATETIME 등이 될 수 있습니다. */

/* CAST(expression AS type)
expression은 변환할 값입니다.
type은 변환하려는 데이터 타입입니다. 예를 들어, CHAR, DATE, DATETIME, SIGNED 등이 될 수 있습니다.*/

-- 샘플
/*60번 IT부서의 사원 급여를 12.3%인상하여 정수만(반올림) 표시하는 보고서 작성
출력형식은 사번, 이름과 성, 급여, 인상된 급여(Increased Salary)*/
SELECT employee_id, CONCAT(first_name, ' ', last_name) as Name, salary , ROUND( salary*1.123 ,0) AS 'Increased Salary'
FROM employees
WHERE department_id=60;

-- 문제 1
/*성이 s로 끝나는 사원의 이름과 업무
이름과 성의 첫글자는 대문자로, 업무는 모두 대문자로, 머리글은 Employee JOBs.*/
SELECT concat (first_name,' ', last_name,' is a ', UPPER(job_id)) as 'Employee JOBs.'
FROM employees
WHERE last_name LIKE '%s';

/* concat (concat(Upper(substring(first_name,1,1)) , lower(substring(first_name,2,char_length(first_name)))),
' ', concat(Upper(substring(last_name,1,1)) , lower(substring(last_name,2,char_length(last_name)))),' is a ', UPPER(job_id)) as 'Employee JOBs.' */

 -- concat(Upper(substring(first_name,1,1)) , lower(substring(first_name,2,char_length(first_name))))
 -- concat(Upper(substring(last_name,1,1)) , lower(substring(last_name,2,char_length(last_name))))

-- 문제 2
/* 사원의 성과 이름, 급여, 수당여부에 따른 연봉
수당여부는 수당이 있으면 salary + commission
수당이 없으면 salary only
연봉이 높은 순
*/
SELECT CONCAT(first_name, ' ', last_name) as Name , salary , salary *12  as Annual_Salary ,
	CASE
    WHEN commission_pct IS NOT NULL THEN 'Salary + Commission'
    ELSE 'Salary Only'
    END
    AS 'Commission?'
FROM employees
ORDER BY Annual_Salary  DESC;

-- 문제 3
/* 성과 이름, 입사일, 입사한 요일을 출력
한 주의 시작인 이룡일부터 출력되도록 정렬하시오
*/
SELECT CONCAT(first_name, ' ', last_name) as Name , hire_date, date_format(hire_date, '%W') AS 'Day of the week'
FROM employees
ORDER BY date_format(hire_date, '%w') ; 