-- 분석함수

-- 샘플
-- 부서별 급여합계, 
-- 급여 합계가 제일 큰것이 1  제일 작은 것이 4가 되도록 등급 나누어 등급 오름차순


SELECT department_id, SUM(salary) AS 'SUM_Salary'
		, NTILE(4) over (order by SUM(salary) DESC ) AS 'BUCKET#'    -- SUM(salary)가 높은 순부터 4개의 등급으로 나눈다.
 FROM employees
 group by department_id
ORDER BY 3 ;					-- 3번째 컬럼인 NTILE(4) over (order by SUM(salary) DESC ) AS 'BUCKET#'  기준으로 정렬

-- 문제 1
/* 각 사원이 부서별로 오름차순, 급여를 기준으로 내림차순 정렬
rank() - 동등 순위 발생 시 다음순위는 중복된 값만큼 증가
dense_rank() - 동등순위가 발생하더라도 바로 다음 번호로
row_number() -= 동등순위 자체를 인식하지 않고 매번 번호 증가
*/

select employee_id, last_name, salary, department_id
	,rank() over(partition by department_id order by salary Desc) as 'Rank'
    , dense_rank() over(partition by department_id order by salary Desc) as 'dense_rank'
    ,row_number() over(partition by department_id order by salary Desc) as 'row_number'
from employees
order by department_id, salary desc;

-- 문제 2
/*
지정된 개수의 이전, 이후 행의 값을 가져오는 LAG, LEAD함수를 이용
50번 부서의 사원정보를 급여순으로 내림차순 정렬
이전행, 다음행의 급여 함께
*/

SELECT employee_id, 
       last_name, 
       salary, 
       LAG(salary, 1, 0) OVER (order by salary desc) AS'previous_salary', 
       LEAD(salary, 1, 0)OVER (order by salary desc)  AS 'next_salary'
FROM employees
WHERE department_id = 50
ORDER BY salary DESC;
