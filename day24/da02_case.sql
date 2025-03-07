-- 조건부 논리 표현식 제어- case

/*
case
when 조건 then 실행문
when 조건 then 실행문
else 실행문
end

case 대상값
when 비교값 then 실행문
when 비교값 then 실행문
else 실행문
end
*/

-- 샘플
-- 사원테이블에서 급여인상
-- 조건 
/*
HR_REP 10%
MK_REP 12%
PR_REP 15%
SA_REP 18%
IT_PROG 20%
*/

SELECT employee_id,CONCAT(first_name ,' ', last_name) as 'Name' ,job_id ,salary,
 case job_id
 when 'HR_REP' then salary*1.1 
 when  'MK_REP' then salary*1.12 
 when  'PR_REP' then salary*1.15 
 when  'SA_REP' then salary*1.18 
 when  'IT_PROG' then salary*1.2 
 else salary
 end
 AS 'New Salary'
FROM employees;

-- 샘플문제
/* 1998년이전, 1999년이전,2000년이전 입사자들의 급여를 각각 5,3,1% 인상
입사일자 오름차순
*/

SELECT employee_id,CONCAT(first_name ,' ', last_name) as 'Name' ,hire_date ,salary,
 case
 when hire_date < '1998-01-01' then salary*1.05
 when  hire_date < '1999-01-01' then salary*1.03
 when   hire_date < '2000-01-01' then salary*1.01
 else salary
 end
 AS 'New Salary'
FROM employees
ORDER BY hire_date;

-- 문제1 
-- 부서별 급여 합계
SELECT department_id , SUM(salary) AS '부서별 급여 합계' , 
	CASE 
    WHEN SUM(salary) > 100000 THEN 'Excellent'
	WHEN SUM(salary) >50000 THEN 'Good'
	WHEN SUM(salary) > 10000 THEN 'Medium'
    ELSE 'Well'
    END
    AS 'Department Grade Salary'
 FROM employees
 group by department_id ;
 
 -- 문제2 
 /* 2005년 이전에 입사한 사원 중 업무에 'MGR'가 포함된 사원의 급여 15%인상 
 2005년 이전에 입사한 사원 중 업무에 'MAN'가 포함된 사원의 급여 20%인상
 2005년부터 근무한 사원중  업무에 'MGR'가 포함된 사원의 급여 25%인상 */
 
 
SELECT employee_id,CONCAT(first_name ,' ', last_name) as 'Name' ,job_id,hire_date ,salary,
 case
 when hire_date < '2005-01-01' and job_id like '%MGR%' then salary*1.15
 when  hire_date < '2005-01-01' and job_id like '%MAN%' then salary*1.2
 when   hire_date >= '2005-01-01' and job_id like '%MGR%' then salary*1.25
 else salary
 end
 AS 'New Salary'
FROM employees
where job_id like '%MGR%'  or job_id like '%MAN%' ;



-- 행변환 cast(EXPRESSION AS DATA TYPE), convert(EXPRESSION , DATA TYPE)
 -- unsigned (양수만)  , signed (음수포함)
select '1006';
select cast('1006' as unsigned);
select convert('-1006' , signed);    -- -1006
select convert('00009' , CHAR);      -- 00009
select convert('00009' , unsigned);  -- 9
select convert('20250307' ,DATE);    -- 2025-03-07


-- 문제3
/*
월별로 입사한 사원수가 아래와 같이 행별로 출력alter
1월 2월 3월  ... 12월
14   0   0        0
 0   13   0        0
*/




-- 월만 추출해서 숫자로 행변환
select convert( date_format(hire_date , '%m') , signed), count(*)
from employees
group by convert( date_format(hire_date , '%m') , signed);

-- step1)case문 사용 1월~12월까지 expand
select case
		when   t.mon = 1 then  mon_sum
        else 0
        end 	
        as '1월' ,
         case
		when   t.mon = 2 then  mon_sum
        else 0
        end 	
        as '2월',
         case
		when   t.mon = 3 then  mon_sum
        else 0
        end 	
        as '3월',
         case
		when   t.mon = 4 then  mon_sum
        else 0
        end 	
        as '4월',
         case
		when   t.mon = 5 then  mon_sum
        else 0
        end 	
        as '5월',
         case
		when   t.mon = 6 then  mon_sum
        else 0
        end 	
        as '6월',
         case
		when   t.mon = 7 then  mon_sum
        else 0
        end 	
        as '7월',
         case
		when   t.mon =8 then  mon_sum
        else 0
        end 	
        as '8월',
         case
		when   t.mon = 9 then  mon_sum
        else 0
        end 	
        as '9월',
         case
		when   t.mon = 10 then  mon_sum
        else 0
        end 	
        as '10월',
         case
		when   t.mon = 11 then  mon_sum
        else 0
        end 	
        as '11월',
         case
		when   t.mon = 12 then  mon_sum
        else 0
        end 	
        as '12월'
from (select convert( date_format(hire_date , '%m') , signed) as mon, count(*) as mon_sum
		from employees
		group by convert( date_format(hire_date , '%m') , signed)
        order by mon asc) as t;

-- -------------- 강사님 코드

-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'hr.employees.hire_date' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
-- 위의 에러 해결코드
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select 
		case  convert( date_format(hire_date , '%m') , signed)  when 1 then count(*) else 0 end as '1월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 2 then count(*) else 0 end as '2월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 3 then count(*) else 0 end as '3월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 4 then count(*) else 0 end as '4월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 5 then count(*) else 0 end as '5월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 6 then count(*) else 0 end as '6월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 7 then count(*) else 0 end as '7월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 8 then count(*) else 0 end as '8월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 9 then count(*) else 0 end as '9월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 10 then count(*) else 0 end as '10월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 11 then count(*) else 0 end as '11월' ,
        case  convert( date_format(hire_date , '%m') , signed)  when 12 then count(*) else 0 end as '12월' 
		from employees
		group by convert( date_format(hire_date , '%m') , signed) 
        order by  convert( date_format(hire_date , '%m') , signed);
        
        

