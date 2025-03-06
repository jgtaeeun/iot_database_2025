-- 집계함수

-- 집계함수 종류 - sum(), avg(), count(), max(), min()
-- group by
-- having절 -집계함수에 대한 조건을 지정할 수 있음

-- 샘플
/*모든 사원은 직속 상사 및 직속 직원을 갖는다. 
단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다.
소속된 사원 중 어떤 사원의 상사로 근무 중인 사원의 총수를 출력하시오*/

select count(*)
from employees
where manager_id is not null
group by manager_id;

select count(distinct manager_id) 
from employees;

-- 문제 1
/*
각 사원이 소속된 부서별
급여 합계, 급여 평군, 급여 최댓값, 급여 최솟값
출력값은 여섯자리와 세자리 구분기호$
부서번호 오름차순
부서에 소속되지 않은 사원에 대한 정보는 제외

*/

select department_id ,
		concat('$',format(round(sum(salary),0) , 0) )as salary ,  
        concat('$',format( round(avg(salary),1) , 1) ) as average,
		concat('$',format(round(max(salary),0) , 0) )as max,
        concat('$',format( round(min(salary),0)  , 0) ) as min
from employees
where department_id is not null
group by department_id;

-- 문제 2
/*
업무별 전체 급여 평균이 10000보다 큰 경우 조회
업무, 급여 평균을 출력
업무에 사원(CLERK)이 포함된 경우 제외
전체급여평균 높은 순
*/
SELECT job_id, AVG(salary) AS ' AVG Salary'
FROM employees
WHERE job_id NOT LIKE '%CLERK%'
group by job_id
HAVING AVG(salary) >10000
ORDER BY  AVG(salary) DESC;

