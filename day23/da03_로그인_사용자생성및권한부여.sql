-- 내부 참조
CREATE USER madang@localhost IDENTIFIED BY 'madang';

-- 외부 참조
CREATE USER madang@'%' IDENTIFIED BY 'madang';

-- 권한 : revoke, grant
-- 데이터삽입, 조회, 수정만 권한 부여
GRANT SELECT , INSERT, UPDATE ON  madang.* to madang@localhost with grant option;
FLUSH PRIVILEGES;

GRANT SELECT , INSERT, UPDATE ON  madang.* to madang@'%' with grant option;
FLUSH PRIVILEGES;

-- 사용자madang에게 madang DB를 사용할 수 있는 모든 권한 부여
GRANT ALL PRIVILEGES ON  madang.* to madang@localhost with grant option;

GRANT ALL PRIVILEGES ON  madang.* to madang@'%' with grant option;
FLUSH PRIVILEGES;

-- 권한 해제 
-- 사용자madang의 권한 중 SELECT만 권한 해제 하겠다.
REVOKE SELECT ON madang.* FROM  madang@localhost;
REVOKE ALL PRIVILEGES ON madang.* FROM  madang@localhost;
FLUSH PRIVILEGES;
