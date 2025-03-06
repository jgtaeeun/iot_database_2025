-- 아이템 ID, 아이템 명, 아이템의 희귀도, 아이템의 가격을 나타냅니다.
CREATE TABLE ITEM_INFO(
ITEM_ID	INTEGER	NOT NULL,
ITEM_NAME	VARCHAR(45)	NOT NULL,
RARITY	INTEGER		NOT NULL,
PRICE	INTEGER	NOT NULL,
PRIMARY KEY (ITEM_ID)
);

CREATE TABLE ITEM_TREE(
ITEM_ID	INTEGER	NOT NULL,
PARENT_ITEM_ID	INTEGER	,
PRIMARY KEY (ITEM_ID)
);

SELECT * FROM shcool_programmers.ITEM_INFO;
SELECT * FROM shcool_programmers.ITEM_TREE;

-- 아이템의 희귀도가 'RARE'인 아이템들의 모든 다음 업그레이드 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
-- 이때 결과는 아이템 ID를 기준으로 내림차순 정렬주세요.

-- 부모테이블에서  RARE을 가진 아이디를 찾는다.
-- 부모테이블의 아이디를 가지는 자식테이블을 찾는다. ->있어야지 부모테이블의 아이디가 업데이트 가능하므로



SELECT i.ITEM_ID, i.ITEM_NAME, i.RARITY
 FROM ITEM_INFO i
JOIN  ITEM_TREE t
ON i.ITEM_ID = t.ITEM_ID
WHERE t.PARENT_ITEM_ID IN (SELECT ITEM_ID FROM ITEM_INFO WHERE RARITY ='RARE')
	AND t.PARENT_ITEM_ID IS NOT NULL
ORDER BY i.ITEM_ID DESC;



