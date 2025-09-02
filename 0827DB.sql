-- (주석표현) 
-- Table 명 : productTBL 

-- SQL에 대해서 알아보아요 
-- 당연히 CRUD에ㅔ 대해서 알아볼거에요 

-- 고객테이블에서 모든 고객의 이름ㅇ르 알아보세요 
-- 가독성을 위해서 Keyword는 대문자를 이용
-- 일반적인 이름(테이블명, 컬럼명)은 소문자를 이용

USE shopdb;  
-- 질의 
SELECT memberName FROM shopdb.member_tbl;  

-- 제품테이블에서 
-- (모든) 제품의 이름과 남은 수량을 알고 싶어요 

SELECT * FROM shopdb.member_tbl; 
SELECT productName, productAmount 
	FROM shopdb.productTBL;
    
    
-- SELECT 컬럼명들 
	-- FROM DB명.테이블명 
    
    
-- 강감찬이라는 고객의 주소를 알고 싶어요 
SELECT MEMBERADDRESS 
FROM shopdb.MEMBER_TBL 
WHERE MEMBERNAME = '강감찬';

SELECT '''A''''';  						-- 틀렸넴...? 

-- 우리 가게의 모든 고객에 대해서 모든 고객 정보를 출력하세요 
-- 만약 COLUMN이 10개라면 -> 모든 컬럼을 지칭하는 * 를 사용 
SELECT * FROM shopdb.member_tbl;

-- SQL을 이용해서 특정 SCHEMA에 존재하는 테이블을 확인할 때 
SHOW TABLES; 


-- 이와 유사하게 현재 사용자가 이용 할 수 있는 SCHEMA가 어떤게 있는지 확인 할 떄 
SHOW DATABASES; 

-- 테이블의 상세를 알고싶어요 
-- 데이블이 가지고 있는 데이터 말고 
-- 테이블이 가지는 컬럼명, 데이터 타입, 제약조건 등이 알고 싶은 경우
DESC member_TBL;



-- 고객테이블에서 모든 고객의 이름과 주소를 검색하세요
-- AS를 이용해서 alias로 결과집합에 column을 바꿀 수 있어요. 
SELECT memberName AS 고객이름, memberAddress AS 고객주소
FROM shopdb.member_tbl; 


-- 새로운 데이터베이스와 테이블을 생성할 거에요 
-- 코드로 생성할 거에요 

-- 1. 만약 기존에 Schema가 존재하면 삭제
-- DELETE는 테이블의 ROW를 삭제하기 위해 사용
-- DROP은 TABLE 자체, SCHEMA 자체를 삭제 하기 위해서 사용
DROP DATABASE SQLDB;							-- SCHEMA가 없으면 ERROR 
DROP DATABASE IF EXISTS SQLDB; 					-- SALDB가 있으면 삭제 없어도 ERROR 발생하지 않음 / 경고발생



-- 2. 새로운 스키마를 생성
CREATE DATABASE SQLDB; 							-- CREATE SCHEMA SQLDB; 		-- 같은 거 



-- 3. 생성된 SQLDB 스키마를 사용
USE SQLDB; 



-- 4. 새로운 테이블 하나 생성
CREATE TABLE USERTBL(
	USERID			CHAR(8)			PRIMARY KEY			NOT NULL, 
    USERNAME		VARCHAR(10)							NOT NULL,
    BIRTHYEAR		INT									NOT NULL, 
    ADDR			VARCHAR(45)									, 
    MOBILE1 		VARCHAR(10)									, -- 국번 (010, 011, 019, 017)
    MOBILE2			VARCHAR(10)									,
    HEIGHT 			INT 										, 
    MDATE			date										 -- 회원가입 한 날짜
); 

CREATE TABLE BUYTBL(
	NUM				INT			AUTO_INCREMENT	PRIMARY KEY	NOT NULL, 
    USERID			CHAR(8)									NOT NULL,
    PRODNAME		VARCHAR(10)								NOT NULL, 
    GROUPPNAME		VARCHAR(10)										, 
    PRICE		 	INT										NOT NULL,  
    AMOUNT 			INT 									NOT NULL, 
    FOREIGN KEY(USERID) REFERENCES USERTBL(USERID) 
); 




-- 5. 만들어진 테이블 안에는 당연히 데이터가 없어요. 
-- 확인 한 번 하고 가요 
SELECT * FROM USERTBL; 



-- 6. 테이블에 데이터 삽입
-- USERTBL부터 데이터를 입력해야 해요 (FOREIGN KEY 때문)
-- TABLE에 데이터를 입력하는 SQL문 사용
 INSERT INTO USERTBL 
		VALUES ('hong', '홍길동', 1990, '서울', '010', '1111-1111', 180, '2025-01-01')
 
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');



INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL , 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL , 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);

SELECT * FROM usertbl; 
SELECT * FROM BUYTBL; 


-- 간단한 QUERY문을 작성해 보아요
-- 7. 사용자 이름이 김경호 인 사람을 찾아서 해당사람의 정보를 출력하세요 
SELECT * 
	FROM USERTBL 
    WHERE 
		USERNAME = '김경호'; 


-- 8. 1970년 이후에 출생하고 신장이 182이상인 사람의 아이디와 이름을 조회하세요 
SELECT USERID, USERNAME
	FROM USERTBL 
    WHERE 
		 BIRTHYEAR >= 1970  
		AND HEIGHT >= 182; 

-- 1970년 이후에 출생하거나 신장이 182이상인 사람의 아이디와 이름을 조회하세요 
SELECT USERID, USERNAME
	FROM USERTBL 
    WHERE 
		 BIRTHYEAR >= 1970  
		OR HEIGHT >= 182; 
        
        
-- 10. 키가 180 ~ 183인 사람의 이름을 조회하세요. 
SELECT USERNAME 
	FROM USERTBL
    WHERE HEIGHT 
		BETWEEN 180 AND 183; 


-- 11. 주소가 '경남', '전남', '경북'인 사람의 이름을 조회하세요 
-- in()을 사용할 수 있어요, discrete한 값인 경우 
SELECT USERNAME 
	FROM USERTBL 
	WHERE ADDR 
		IN ('경남', '전남', '경북');



-- 12. 아주 많이 사용하는 기능 중 패턴매칭이 있어요 
-- 패턴매칭을 하려면 WILDCARD 기호를 알아야 해요
-- 기호가 2개 있어요 => _, %
-- % : 0개 이상의 글자 
-- _ : 1개의 글자를 의미
-- 김% : 김, 김길동, 김이, 김호호호, 김수한무거북이와두루미삼천갑자동방사 ==> 김으로 시작하는 모든 문자열
-- 김_ : 김치, 김박, 김이 ==> 김으로 시작하는 2글자 문자열
-- %만두% : 만두가 포함되어 있는 모든 문자열

-- 성이 김씨인 모든 사람을 찾아서 사람의 이름을 출력하세요 
SELECT USERNAME FROM USERTBL WHERE USERNAME LIKE '%김%'; 

