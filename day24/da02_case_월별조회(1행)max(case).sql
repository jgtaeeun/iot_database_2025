SELECT 
    MAX(CASE WHEN t.mon = 1 THEN t.mon_sum ELSE 0 END) AS Jan,
    MAX(CASE WHEN  t.mon = 2 THEN  t.mon_sum ELSE 0 END) AS Feb,
    MAX(CASE WHEN  t.mon= 3 THEN  t.mon_sum ELSE 0 END) AS Mar,
    MAX(CASE WHEN  t.mon= 4 THEN  t.mon_sum ELSE 0 END) AS Apr,
    MAX(CASE WHEN t.mon= 5 THEN  t.mon_sum ELSE 0 END) AS May,
    MAX(CASE WHEN  t.mon = 6 THEN  t.mon_sum ELSE 0 END) AS Jun,
    MAX(CASE WHEN  t.mon = 7 THEN  t.mon_sum ELSE 0 END) AS Jul,
    MAX(CASE WHEN  t.mon= 8 THEN  t.mon_sum ELSE 0 END) AS Aug,
    MAX(CASE WHEN  t.mon = 9 THEN  t.mon_sum ELSE 0 END) AS Sep,
    MAX(CASE WHEN  t.mon = 10 THEN  t.mon_sum ELSE 0 END) AS Oct,
    MAX(CASE WHEN  t.mon= 11 THEN  t.mon_sum ELSE 0 END) AS Nov,
    MAX(CASE WHEN  t.mon = 12 THEN  t.mon_sum ELSE 0 END) AS 'Dec' 
FROM (
    SELECT 
        CAST(DATE_FORMAT(hire_date, '%m') AS UNSIGNED) AS mon, 
        COUNT(*) AS mon_sum
    FROM employees
    GROUP BY mon
) AS t;
