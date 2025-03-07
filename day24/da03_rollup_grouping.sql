--  다차원 그룹 데이터 검색 - ROLLUP
-- 샘플
/*
부서와 업무별 급여 합계를 기준으로 나누어 급여합계와 인원수
*/
SELECT @@sql_mode;
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY';
SET SESSION sql_mode = 'STRICT_TRANS_TABLES, NO_ZERO_IN_DATE, NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO, NO_ENGINE_SUBSTITUTION';



 SELECT  department_id, job_id, CONCAT('$' , SUM(salary)) as 'Salary Sum' , count(employee_id) as 'count emps'
 FROM employees
 group by department_id, job_id
 ORDER BY department_id;
 
 
 -- 샘플
 /*
 위 결과에서 부서번호와 업무로 그룹화된 총합계, 총인원수 - 각 그룹별
 */
 -- group by 의 컬럼이 하나면 총계는 하나/ 컬럼이 두개면 첫번째 컬럼별로 소계, 이후 두 컬럼의 합산이 총계, 전체 그룹화 총계
 
 SELECT  department_id, job_id, CONCAT('$' , SUM(salary)) as 'Salary Sum' , count(employee_id) as 'count emps'
 FROM employees
 group by department_id, job_id WITH ROLLUP; -- 전체를 그룹화한 수행 결과 1/ 부서에 대해서만 그룹화 수행결과 12 /부서와 업무별 그룹화 수행결과 20 =>총 33행
 
 -- 문제 1
 /*
 샘플문제에서
 부서에 대한 집계 결과가 아니면 all-depths 
 업무에 대한 집계 결과가 아니면 all-jobs
 
 */
 
 -- grouping() 함수를 사용하여 그룹화된 컬럼의 수준을 확인합니다.
 -- 전체를 그룹화한 수행 결과 1 all-depths   all-jobs/ 부서에 대해서만 그룹화 수행결과 12  all-jobs/부서와 업무별 그룹화 수행결과 20 =>총 33행
 SELECT  department_id, job_id, 
		CONCAT('$' , SUM(salary)) as 'Salary Sum' ,
		count(employee_id) as 'count emps',
        grouping(department_id),
        grouping(job_id)
 FROM employees
 group by department_id, job_id WITH ROLLUP;
 
 
  SELECT  department_id,
		case grouping(department_id) 
        when 1 then '(all-depts)' 
        else ifnull(department_id, '부서없음')
        end
        as 'dept#',
        
        case grouping(job_id) 
        when 1 then '(all-jobs)' 
        else job_id
        end
        as 'jobs',
        
		CONCAT('$' , SUM(salary)) as 'Salary Sum' ,
		count(employee_id) as 'count emps',
        format(avg(salary) *12 ,0)
 FROM employees
 group by department_id, job_id WITH ROLLUP;
 
 