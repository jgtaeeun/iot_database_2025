-- 조인

-- 동등조인 - 공통칼럼 기준으로 같은 행들을 연결
-- 비동등 조인 - 공통컬럼을 기준으로 동등이 아닌 조건으로 연결
-- 셀프조인
-- 외부조인
-- 자연조인

-- 샘플
/*
Oxford에 근무하는 사원의 성과 이름, 업무, 부서명, 도시명
첫번째 열은 회사명인 'Han-Bit'라는 상수값

employees, departments, locations 조인
부모-자녀 departments employees / locations - departments
*/

SELECT 'Han-Bit' as '회사명', concat(first_name, ' ', last_name) as Name, job_id, department_name, city
FROM employees e, departments d, locations l
where d.department_id = e.department_id
 and l.location_id= d.location_id
 and l.city = 'Oxford';

-- 문제1
/* employees와 departments 테이블 구조 파악 후
사원수가 5명 이상인 부서의 부서명과 사원수를 출력하시오
사원수가 많은 순으로 정렬
*/
select  department_name , count(e.employee_id) as '사원수'
from departments d, employees e
where d.department_id = e.department_id
group by d.department_id
having count(e.employee_id) >= 5
order by 사원수 desc;

-- 문제 2
--  job_grades사원의 성과 이름, 업무, 부서명, 입사일, 급여, 급여 등급
desc job_grades;

select * from job_grades;
select * from employees;



select concat(first_name , ' ' , last_name) as Name, job_id, d.department_id , hire_date, salary ,
		(select grade_level from job_grades
        where e.salary between lowest_sal and highest_sal) as grade_level
from departments d, employees e
where d.department_id = e.department_id
order by salary desc;

-- 문제3
/*각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하라.
*/
-- 셀프조인
select concat(c.first_name , ' ' , c.last_name) as employee , 'report to' as 'report to' , UPPER(concat(p.first_name , ' ' , p.last_name)) as manager
from employees p
RIGHT JOIN employees c
ON p.employee_id = c.manager_id;


