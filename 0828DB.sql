-- SQL 문장에 대해 계속 알아보아요 

USE SQLDB; 

SELECT * 
	FROM sqldb.usertbl; 

-- ####################################################################################

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 조회하세요 
SELECT HEIGHT 
	FROM USERTBL 
    WHERE USERNAME = '김경호'; 

SELECT USERNAME, HEIGHT 
	FROM USERTBL 
    WHERE HEIGHT >=
		( SELECT HEIGHT 
				FROM USERTBL 
                WHERE USERNAME = '김경호'); 
	
    
-- 지역이 '경남'인 사람의 키보다 키가 크거나 같은 사람의 이름을 조회하세요 
SELECT * 
	FROM USERTBL 
    WHERE ADDR = '경남'; 
    
    
-- ANY 
SELECT USERNAME
	FROM USERTBL 
    WHERE HEIGHT >= ANY(SELECT MIN(HEIGHT) 
						FROM USERTBL 
                        WHERE ADDR = '경남'); 
                        
-- ALL
SELECT USERNAME
	FROM USERTBL 
    WHERE HEIGHT >= ALL(SELECT MIN(HEIGHT) 
						FROM USERTBL 
                        WHERE ADDR = '경남'); 
                        

-- 출력 결과를 정돈해서 보고 싶어요 
-- 먼저 가입한 순서대로 회원의 이름과 가입날짜를 출력하세요 
-- 정렬의 기본은 당연히 오름차순 정렬! (작은게 앞으로 ASC : 오름차순, 작은게 위로DESC : 내림차순) 
-- 하지만 정렬은 생각보다 부하가 많이 걸리는 작업이에요 -> 시간이 오래 걸릴 수 있어요 
-- 이차정렬 가능 
-- 꼭 필요한 작업에서만 하는게 맞음
SELECT USERNAME AS '회원명', 
	   MDATE 	AS '가입일자'
	FROM USERTBL 
	ORDER BY MDATE ASC; 


-- 중복제거 
-- 모든 회원의 주소를 검색하세요 -> 어떤 지역의 회원들이 있는지 확인하고 싶음
SELECT DISTINCT(ADDR) FROM USERTBL;


-- 회원 중 가입일짜가 빠른 5명의 이름과 가입일 
SELECT USERNAME, MDATE
	FROM USERTBL 
    ORDER BY MDATE ASC
    LIMIT 5; 
    

-- 그러면 살짝 응용해서 이런 거 할 수 있어요 
-- 하나의 테이블의 내용을 복사해서 다른 테이블을 만들 수 있어요 
-- 테이블의 내용을 복사하려면
-- 1. 새로운 테이블을 만들어요 (CREATE TABLE ~)
-- 2. 기존 테이블에서 내용을 가져와요 (SELECT * ~
-- 3. 가져 온 데이터를 새로운 테이블에 입력(INSERT INTO) 

-- 이 작업을 SUBQUERY를 이용해서 한방에 처리 할 수 있어요 
CREATE TABLE USERTBL2(
	SELECT * FROM USERTBL
); 


-- 구매테이블(BUYTBL)에서 사용자가 구매한 물품의 개수를 출력하세요(종류는 따지지 않고 총 몇개 구매했는지 알고싶어요)
SELECT USERID, AMOUNT
	FROM BUYTBL 
	ORDER BY USERID; 
    
-- 각 사용자별 구매액의 총합을 출력하세요    
SELECT USERID AS '사용자ID', 
	SUM(AMOUNT*PRICE) AS '구매액'
	FROM BUYTBL 
	GROUP BY USERID 
    ORDER BY USERID;
    

-- 이런 GROUPING에서 사용할 수 있는 AGGREGATION FUNCTION(집계함수)는 어떤게 있나요? 
-- 1. SUM()
-- 2. MAX() / MIN()
-- 3. AVG()
-- 4. COUNT()
-- 5. COUNT(DISTINCT) 
-- 6. STDEV() 


-- 전체 구매자가 구매한 물품의 평균갯수는 몇 개 인가요? 
SELECT SUM(AMOUNT) FROM BUYTBL; 
SELECT COUNT(DISTINCT(USERID)) FROM BUYTBL; 


SELECT AVG(AMOUNT) 
	FROM BUYTBL ;
    
    
SELECT * FROM BUYTBL; 
    
    
-- 각 사용자 별로 한번 구매했을 때 평균 몇개 구매?
SELECT USERID, ROUND(AVG(AMOUNT), 2)
	FROM BUYTBL 
    GROUP BY USERID; 
    
    

    

SELECT USERID, 
	PRODNAME, 
    (SELECT SUM(AMOUNT * PRICE) FROM BUYTBL WHERE USERID1 = USERID GROUP BY USERID) AS SUM
	FROM BUYTBL
	GROUP BY USERID, PRODNAME
    ORDER BY USERID; 



-- USERTBL에서 가장 큰 키와 가장 작은키의 회원 이름과 키를 조회하세요 
SELECT MIN(HEIGHT), MAX(HEIGHT) FROM USERTBL;



-- 해결이 쉽지 않은 문제를 풀려면 SUBQUERY를 적극적으로 사용하면 좋아요 
SELECT USERNAME, HEIGHT
	FROM USERTBL 
    WHERE HEIGHT = (SELECT MAX(HEIGHT) FROM USERTBL)
		OR HEIGHT = (SELECT MIN(HEIGHT) FROM USERTBL); 


-- 많이 사용하는 기능 중 COUNT()
-- 휴대폰(전화번호)가 있는 사용자는 몇명인가요?
-- COUNT()는 기본적으로 NULL을 배제 
SELECT LEAST(COUNT(MOBILE1), COUNT(MOBILE2))
	FROM USERTBL; 

SELECT * FROM BUYTBL; 
-- 사용자별 총 구매금액이 1000원 이상인 사용자만 이름을 출력하세요! 
-- WHERE 절에선 집계함수를 쓸 수 없어요 


SELECT USERID, SUM(PRICE * AMOUNT) 
	FROM BUYTBL
	GROUP BY USERID
    HAVING SUM(PRICE * AMOUNT) >= 1000;

SELECT SUM(AMOUNT * PRICE) FROM BUYTBL;

SELECT SUM(AMOUNT * PRICE) FROM BUYTBL GROUP BY USERID;


-- 만약 트랜잭션 처리를 하지 않았다면 
-- 단일 SQL 문장이 1개의 TRANSACTION으로 간주되서 처리되어요 
-- TRANSACTION처리를 하지 않는거죠 


-- TABLE부터 하나 만들어 보아요
-- TABLE 생성은 TRANSACTION 작업으로 설정할 수 없어요 

CREATE TABLE MYTBL (
	-- 컬럼, 데이터타입, 제약사항(CONSTRAINTS) 설정
    MY_ID 			INT 		AUTO_INCREMENT 			PRIMARY KEY		NOT NULL, 
    MY_NAME 		CHAR(10)											NOT NULL, 
    MY_AGE			INT 
) 


-- 트랜잭션 시작
START TRANSACTION; 

-- 데이터를 입력 (가짜로 저장) 
INSERT INTO MYTBL VALUES(NULL, '홍길동', 20); 

-- 데이터 입력을 확인
SELECT * FROM buytbl; 
select * from usertbl; 


-- TRANSACTION을 종료
-- 정상종료와 비정상종료
-- 정상종료를 할 때는 COMMIT을 사용 
-- TRANSACTION에서 처리된 모든 결과를 DISK에 영구적으로 저장 
-- 진짜로 저장 


-- 비정상 정료는 ROOLBACK을 사용
-- 비정상 종료되는 TRANSACTION에서 처리된 모든 SQL 구문을 무시 
-- ATOMICITY 특징에 의해 아무것도 안한 상태로 만들어요 
ROLLBACK; 			-- 지금 TRANSACTION이 종료되고 바로 다른 TRANSACTION이 시작되어요 
COMMIT;  




select 


-- TRANSACTION까지 알아보았어요 