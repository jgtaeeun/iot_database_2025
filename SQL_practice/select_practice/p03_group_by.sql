Column name	        Type	        Nullable
ONLINE_SALE_ID	    INTEGER	        FALSE
USER_ID	            INTEGER	        FALSE
PRODUCT_ID	        INTEGER	        FALSE
SALES_AMOUNT	    INTEGER	        FALSE
SALES_DATE	        DATE	        FALSE



-- ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터를 구하여, 재구매한 회원 ID와 재구매한 상품 ID를 출력하는 SQL문을 작성해주세요.
--  결과는 회원 ID를 기준으로 오름차순 정렬해주시고 회원 ID가 같다면 상품 ID를 기준으로 내림차순 정렬해주세요.

SELECT USER_ID, PRODUCT_ID 
FROM ONLINE_SALE
GROUP BY USER_ID , PRODUCT_ID
HAVING COUNT(*) >1
ORDER BY USER_ID, PRODUCT_ID DESC;