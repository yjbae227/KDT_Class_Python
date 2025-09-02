-- 20250901
-- View 
-- Table : 실제 데이터가 저장되는 곳
-- View : 테이블과 유사하지만 실제 데이터가 저장되어 있지 안하요
--         Select 구문이 들어가 있어요

use sqldb;

Select * 
From usertbl;

-- 목적에 따라서 view을 다음과 같이 만들 수 있어요 

CREATE OR REPLACE VIEW v_usertbl 
AS 
   SELECT userid, username, height
    FROM usertbl;
    
SELECT * 
FROM v_usertbl;