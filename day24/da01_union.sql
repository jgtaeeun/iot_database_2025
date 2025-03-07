-- 집합연산자

-- union -중복제거
-- union all - 중복포함

-- mysql미지원 연산자 : intersect , minus

-- 샘플
-- job_history 테이블을 이용하여 모든 사원의 현재 및 이전의 업무 이력 정보를 출력하고자 한다.
SELECT *
 FROM job_history;
 
 SELECT *
  FROM employees;
  
SELECT T.employee_id , T. job_id 
FROM (
	SELECT employee_id, job_id
	 FROM 	employees
	 UNION  SELECT employee_id, job_id
			FROM job_history )	AS T ;

-- 중복인 행 찾기
SELECT *
 FROM employees e, job_history j
 WHERE  e.employee_id = j.employee_id 
	AND e.job_id = j.job_id;
    
-- 문제 1
-- 모든 사원의 업무 이력 전체-중복 포함
-- 업무이력변경 정보 및 업무 변경에 따른 부서정보
-- 사번이 빠른 순서
SELECT  employee_id, job_id , department_id
	FROM employees 
UNION ALL SELECT employee_id, job_id, department_id
			FROM job_history
ORDER BY employee_id;

-- 문제 2
/* 사원정보 테이블의 job_id는 현재업무
	job_history테이블의 job_id는 과거 업무
    교차해보면 업무가 변경된 사원정보도 볼 수 있지만 그대로 하는 사원의 정보도 볼 수 있다.이전과 같은 업무를 하는 사원의 사번과 업무 출력
    */
-- mysql에서는 intersect를 지원하지 않으므로 조인으로 풀고, 다른 데이터베이스는 intersect로 함
-- 조인
SELECT *
 FROM employees e, job_history j
 WHERE  e.employee_id = j.employee_id 
	AND e.job_id = j.job_id;

-- 문제 2-1 ) 176번 사원의 업무 이력의 변경 날짜 이력 조회
-- 집합 구현시 양쪽 테이블의 컬럼수 및 데이터 타입은 반드시 같아야 한다.
-- 만일 공통된 컬럼이 없을 경우, NULL 처리를 하고, 필요에 따라 데이터 타입을 변환하여 일치시킨다.
SELECT * 
FROM (
SELECT *
 FROM job_history 
 UNION ALL (SELECT e.employee_id,  null, null,e.job_id, e.department_id FROM employees e WHERE e.employee_id = 176) ) AS T
 where T.employee_id =176;
 
-- 문제 3
/*
우리 회사는 1년에 한 번 업무를 변경하여 회사업무들을 익히도록 한다.
이번 인사 이동 때 아직 업무가 변경된 적이 없는 사원을 적합한 업무로 이동시키려고 한다.
employees 테이블과 job_history 테이블을 이용하여 한번도 업무가 변경되지 않은 사원의 사번을 출력해라
*/


 SELECT employee_id
  FROM employees
  WHERE employee_id NOT IN (SELECT employee_id FROM job_history);
 
 


