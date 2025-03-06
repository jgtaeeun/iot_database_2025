-- 2. where, order by
-- 샘플
/*사원정보 테이블에서 급여가 $7000~10000범위 이외인 사람
성과 이름 은 name으로 별칭 및
 급여를 급여가 작은 순서로*/
 
 SELECT concat(first_name, ' ' , last_name ) as 'Name' , salary
  FROM employees
  WHERE salary <7000 or salary >10000
  ORDER BY salary;
  
   SELECT concat(first_name, ' ' , last_name ) as 'Name' , salary
  FROM employees
  WHERE salary not between 7000 and 10000
  ORDER BY salary;
  
  -- 문제1
  /*사원의 성(last_name) 중에 e, o 글자가 포함된 사원
  별칭은 e AND o Name*/
  SELECT last_name as 'e AND o Name'
   FROM employees
   WHERE last_name LIKE '%e%' AND last_name LIKE '%o%';
   
   -- 문제2
   /*현재 날짜 타입을 날짜함수를 통해 확인
   1995년 5월 20일부터 1996년 5월20일 사이에 고용된 사원
   이름(Name), 사원번호, 고용일자
   단 입사일 빠른 순*/
   
   SELECT DATE_ADD(sysdate() , interval 9 HOUR) AS 'SYSDATE';
   SELECT concat(first_name, ' ' , last_name )  as 'Name' , employee_id, hire_date
   FROM employees
   WHERE hire_date between '1995-05-20 00:00:00' and '1996-05-20 23:59:59'; -- DATE타입은 문자열처럼 조건연산을 해도 됨
   
   -- 문제 3
   /*급여와 수당률(commission_pct)에 대한 지출보고서 작성하려고 한다.
   수당을 받는 모든 사원의 성과이름, 급여, 업무, 수당률을 출력하라
   급여가 큰 순서, 급여 같으면 수당율이 큰순서
   */
   SELECT concat(first_name, ' ', last_name) as Name , salary, job_id, commission_pct 
   FROM employees
   WHERE commission_pct IS NOT NULL
   ORDER BY salary desc, commission_pct desc;
   
