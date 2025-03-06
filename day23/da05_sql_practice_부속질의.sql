-- 부속질의

-- 샘플
/*Tucker사원보다 급여를 많이 받는 사원의 성과 이름, 업무, 급여출력*/
SELECT CONCAT(first_name ,' ', last_name) as Name, job_id, salary
from employees
where salary > (

SELECT salary
FROM employees
WHERE last_name like '%Tucker%');

-- 문제1
/*사원의 급여 정보 중 업무별 최소 급여를 받는 
사원의 성과 이름, 업무, 급여, 입사일
*/


select CONCAT(first_name ,' ', last_name) as Name, job_id, salary  , hire_date
from employees e1
WHERE salary = (
		select min(e2.salary)
		from employees e2
        WHERE e1.job_id = e2.job_id
);

-- 문제2  상관관계 부속질의
/*소속 부서의 평균 급여보다 많은 급여를 받는 사원
성과 이름, 급여, 부서번호, 업무*/
select CONCAT(first_name ,' ', last_name) as Name, salary , department_id , job_id 
from employees  e1
where salary > (
		select avg(salary)
        from employees e2
        where e1.department_id = e2.department_id

);


-- 문제3 
/* 지역별 근무현황 조회
도시이름이 영문'O'로 시작하는 지역에 살고 있는 사원
사번, 성과 이름, 업무, 입사일 출력
*/
SELECT e.employee_id, concat(first_name, ' ', last_name) as Name, job_id, hire_date
FROM employees e, departments d, locations l
where d.department_id = e.department_id
 and l.location_id = d.location_id
 and l.city LIKE 'O%';

-- 문제4 
/* 소속부서 평균 연봉 계산
성과 이름, 업무, 급여, 부서번호, 부서 평균 연봉 
*/

SELECT  concat(first_name, ' ', last_name) as Name , job_id, salary, e1.department_id, 
(select round(avg(salary),0) from employees e2 where e1.department_id=e2.department_id) as '부서 평균 연봉'
FROM employees e1

