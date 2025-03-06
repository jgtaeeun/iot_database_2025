-- 실무실습 
-- SQL Practice

-- 1. select
-- 샘플문제
/*사원 정보테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오.
이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오 */
SELECT employee_id, concat(first_name,' ', last_name) as 'Name', salary, job_id, hire_date, manager_id
  FROM employees;
  
-- 문제 1
/*사원 정보 테이블에서
성과 이름은 Name, 업무는 Job, 급여는 salary, 연봉에 $100을 추가하여 계산한 값은 Increased Ann_Salary , 급여에 $100 더하여 계산한 연봉은 Increased Ann_Salary  */
SELECT CONCAT(first_name, ' ', last_name) as 'Name', job_id as 'Job' , salary as 'Salary' ,
		salary*12 + 100 as ' Increased Ann_Salary' , (salary + 100 )*12 as ' Increased_Salary'
FROM employees;

-- 문제 2
/*사원 정보 테이블에서 
모든사원의 이름(last_name)과 연봉을 
'이름:1 Year Salary = $연봉' 형식으로 출력하고 별칭은 1 Year Salary */
SELECT CONCAT(last_name, ': 1 Year Salery=$', salary*12) as '1 Year Salary' 
FROM employees;

-- 문제 3
/* 부서별로 담당하는 업무를 한번씩만 출력하시오*/
SELECT distinct department_id, job_id
from employees;

