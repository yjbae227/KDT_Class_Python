-- DML (SELECT, INSERT, UPDATE, DELETE)에 대해서 
-- 알아보아요

USE SQLDB; 

-- 1. INSERT 부터 다시 간단하게 알아보아요 
-- CREATE TABLE SQLDB.TESTTBL1 (
-- 	ID 			INT			auto_increment			PRIMARY KEY					, 
--     USERNAME	CHAR(8)													NOT NULL, 
--     AGE			INT 
-- )

-- 이렇게 테이블을 CREATE를 이용해서 만들 수 있어요 
-- DDL인 CREATE구문을 이용해서 만들었어요 
-- DDL은 TRANCSACTION을 적용할 수 없어요.
-- 테이블은 TRANSACTION과 상관없이 CREATE 하면 그냥 만들어지구요 
-- DROP 하면 그냥 없어져요 


-- TABLE을 만들었으니 이제 데이터를 입력해보아요 
-- DML INSERT 구문을 이용해서 데이터를 입력해요
-- 모든 DML은 TRANSACTION을 처리할 수 있어요 

START TRANSACTION; 


-- 데이터를 입력해요 
INSERT INTO TESTTBL1 VALUES(1, '홍길동', 20); 

COMMIT ; 
SELECT * FROM TESTTBL1; 


-- INSERT 를 이렇게 이용할 수 있어요 
-- 컬럼을 지정해서 입력할 수 있어요 
INSERT INTO TESTTBL1(ID, USERNAME) VALUES(2, '신사임당');

-- 컬럼의 순서도 변경 할 수 ㅣㅆ어요 
INSERT INTO TESTTBL1(USERNAME, ID) VALUES('이순신', 3); 

-- ----------------------------------------------------------------------

-- UPDATE 구문은 어떻게 사용하나요? 
UPDATE TESTTBL1 
	SET AGE = 0 WHERE USERNAME = '이순신'; 
    
    
-- DELETE 구문은 어떻게 사용하나요? 
DELETE FROM TESTTBL1 WHERE USERNAME = '신사임당'; 



-- 추가적으로 알아두어야 하는 사항

-- DataType 
-- DBMS 마다 사용되는 DATA TYPE이 달라요 
-- MYSQL의 DATA TYPE에 대해서 알아보아요 


-- 숫자 
-- 테이블 안에 숫자를 저장할 수 있어요. 컬럼에 데이터 타입을 명시 
-- 상당히 많은 숫자형 타입이 있어요 
-- INT(INTEGER) : 정수 (-21억 ~ +21억) 
-- BIGINT : 정수 (-900경 ~ +900경)
-- FLOAT : 실수 (소수점 이하 7자리까지 표현 가능 - 근사값) 
-- DOUBLE : 실수 (소수점 이하 15자리까지 표현 가능 - 근사값) 
-- DECIMAL : 정수 및 실수 표현(정확한 표현) 


-- 문자 
-- 테이블 안에 당연히 문자열을 저장할 수 있어요 
-- CHAR(N) : 고정 길이 문자열, 최대길이 255
-- VARCHAR(N) : 가변 길이 문자열, 최대길이 65535
-- LONGTEXT : 최대 4G까지의 TEXT 데이터 



-- 날짜 
-- DATE : 연-월-일 형식으로 날짜를 저장
-- DATETIME : 연-월-일 시:분:초 형식으로 날짜와 시간을 저장

-- 데이터타입은 이정도만 알아두시고 혹시 나중에 다른 데이터 타입이 필요한 경우 찾아서 쓰면 됩니다. 




-- 내장함수에 대해서 알아보야요 
-- 프로그래밍 언어처럼 DBMS도 내장함수를 상당히 많이 제공하고 있어요 
-- 다 외울 수 없어요 


-- 문자열 함수 
SELECT '소리없는 아우성'; 

SELECT LENGTH('소리없는 아우성'); 
-- LENGTH() 함수는 문자열을 표현하기 위한 BYTE수를 리턴해요
-- 영어는 1글자가 1BYTE 에요, 한글은 한글자가 3BYTE에요 


-- 내가 원하는 건 언어에 상관없이 글자수 알고싶어요 
SELECT char_length('소리없는 아우성'); 

-- 문자열을 연결시키는 함수가 있어요 
SELECT CONCAT('이것은 ', '소리없는 ', '아우성'); 



-- 숫자인데 3자리마다 콤마를 표현하고 싶어요
SELECT FORMAT(1000000.12345, 2); 


-- 그 외에 정말 많은 함수가 있는데 이건 필요할 때마다 찾아서 사용할 거에요. 


-- JOIN (테이블을 결합할 수 있어요) 
-- 진짜로 테이블이 결합하는 건 아니에요 
-- SQL SELECT 할 때 데이터를 추출하기 위해서 이시로 테이블을 결합해서 사용할 수 있어요 
-- 임시로 테이블을 결합해서 사용할 수 있어요 
-- 가장 중요한 기능 중 하나에요 
-- join으로 해결하는게 가장 효과적인 경우가 많아요 
-- 테이블을 논리적으로 결합하는 이 join은 상당히 부하가 많이 걸려요 
-- (연산이 오래 걸려요, 메모리를 많이 차지해요) 


-- join은 두개 이상의 테이블을 묶어서 하나의 결과집합을 생성하는 연산 
-- 기본적으로 JOIN을 하려면 두 개의 테ㅔ이블이 연관관계를 맺고 있어야 해요 
-- FOREIGN KEY(외래키)를 이용해서 테이블간의 RELATION(연간관계)를 맺고 JOIN을 이용해서 결합시킬 수 있어요 


-- JOIN의 종류는 여러가지가 있어요 
-- 가장 대표적인 JOIN은 INNER JOIN이라고 불러요 


-- 문법적으로 어떻게 표현하는지 알아야 해요 
-- SELECT <컬럼 목록>  FROM <첫번째 테이블> INNER JOIN <두번째 테이블> ON <결합 조건-조인 조건> 
-- WHERE / GROUP BY / HAVING / ORDER BY 


-- 예를 들어서 알아보아요 
SELECT * FROM USERTBL; 

-- 고객 구매 내역 정보 
SELECT * FROM BUYTBL; 


-- 구매 테ㅔ이블에서 JYP라는 아이디를 가진 사람이 구매한 물건을 발송하기 위해서 주소가 필요해요 
SELECT ADDR 
	FROM USERTBL U 
		INNER JOIN BUYTBL B 
        ON U.USERID = B.USERID 
	WHERE B.USERID = 'JYP';


-- 물품을 한번이라도 구매한 기록이 있는 회원들에게 감사의 선물을 보내려고 해요 
-- 구매 이력이 존재하는 회원의 이름과 주소를 알고싶어요 


SELECT DISTINCT(U.USERNAME), U.ADDR 
	FROM USERTBL U 
		INNER JOIN BUYTBL B 
		ON U.USERID = B.USERID; 
        
        
-- JOIN 없이 쓰는 법
SELECT USERNAME, ADDR
	FROM USERTBL
    WHERE EXISTS(
		SELECT * 
		FROM BUYTBL
        WHERE USERTBL.USERID = BUYTBL.USERID
	); 
    


-- INNER JOIN 연습을 해 보아요 
-- TABLE이 있어야 하고 TABLE 간의 관계를 맺어줘야 해요 
-- 테이블 3개를 만들거에요 
-- 학생 테이블, 동아리 테이블, 학생-동아리 테이블 
-- 학생 정보는 이름과 주소 => PK : 이름 
-- 동아리 정보는 동아리 이름과 호실(101호) => PK : 동아리이름
-- 학생-동아리 정보는 학생이 동아리에 가입한 정보 (N:M 관계) => 번호, 동아리이름, 학생이름


-- 사용할 스키마 
USE SQLDB; 

-- 테이블 생성
-- 학생 테이블 
CREATE TABLE STDTBL(
	STDNAME			VARCHAR(10) 		PRIMARY KEY		NOT NULL, 
    STDADDR			VARCHAR(10)							NOT NULL
); 

-- 동아리 테이블 
CREATE TABLE CLUBTBL(
	CLUBNAME		VARCHAR(10) 		PRIMARY KEY 	NOT NULL, 
    ROOMNO			VARCHAR(10)							NOT NULL 
);

-- 학생-동아리 가입 테이블
CREATE TABLE STDCLUBTBL (
	NUM 		INT 			AUTO_INCREMENT 		PRIMARY KEY		NOT NULL, 
    STDNAME 	VARCHAR(10) 					 					NOT NULL, 
    CLUBNAME 	VARCHAR(10) 										NOT NULL, 
    FOREIGN KEY(STDNAME) REFERENCES STDTBL(STDNAME),
    FOREIGN KEY(CLUBNAME) REFERENCES CLUBTBL(CLUBNAME)    
);




-- 데이터입력!

INSERT INTO stdtbl VALUES ('김범수', '경남');    
INSERT INTO stdtbl VALUES ('성시경', '서울');    
INSERT INTO stdtbl VALUES ('조용필', '경기');    
INSERT INTO stdtbl VALUES ('은지원', '경북');    
INSERT INTO stdtbl VALUES ('바비킴', '서울');


INSERT INTO clubtbl VALUES ('수영', '101호');
INSERT INTO clubtbl VALUES ('바둑', '102호');
INSERT INTO clubtbl VALUES ('축구', '103호');
INSERT INTO clubtbl VALUES ('봉사', '104호');


INSERT INTO stdclubtbl VALUES (NULL, '김범수', '바둑');
INSERT INTO stdclubtbl VALUES (NULL, '김범수', '축구');
INSERT INTO stdclubtbl VALUES (NULL, '조용필', '축구');
INSERT INTO stdclubtbl VALUES (NULL, '은지원', '축구');
INSERT INTO stdclubtbl VALUES (NULL, '은지원', '봉사');
INSERT INTO stdclubtbl VALUES (NULL, '바비킴', '봉사');



 -- 1. 학생을 기준으로 학생이름, 지역, 가입한 동아리 이름, 동아리 방을 출력하세요 
 
 SELECT S.STDNAME, S.STDADDR, C.CLUBNAME, C.ROOMNO 
	FROM STDTBL S 
        INNER JOIN STDCLUBTBL SC
			ON S.STDNAME = SC.STDNAME
        INNER JOIN CLUBTBL C
			ON C.CLUBNAME = SC.CLUBNAME
		ORDER BY S.STDNAME ;
        
        
        
-- 거의 대부분 INNER JOIN을 사용해요 
-- 몇 가지 경우에 또 다른 JOIN을 사용해요! 
-- OUTER JOIN(LEFT, RIGHT, FULL) 
-- 문법도 살짝 달라요 


-- SELECT 컬럼들 
-- FROM 첫번째 테이블(LEFT 테이블) 
-- 		LEFT OUTER JOIN 두번ㅇ째 테이블 (RIGHT 테이블)
-- 		ON 조인조건
-- 	WHERE ~


-- 쉽게 OUTER JOIN을 이해하려면
-- INNER JOIN을 먼저 수행하고 추가적인 데이터를 결과에 붙이다고 생각하면 되어요
-- 조인에 포함되지 못한 양측 테이블의 데이블 결과에 붙인닫고 생각하면 되요alter


-- 잠시 예제를 사용자테이블과 구매테이블로 돌아갈거에요 
-- USERTBL / BUYTBL 


-- 전체 회원의 구매기록을 조회하세요. 
-- 단 구매기록이 없는 회원도 출력되어야 합니다. 

SELECT *
	FROM USERTBL U 
		LEFT OUTER JOIN BUYTBL B
		ON U.USERID = B.USERID; 
        
        
-- 한번도 구매한 적이 없는 회원의 목록(회원의 이름과 주소)를 출력하세요 

SELECT * 
	FROM USERTBL U 
		LEFT OUTER JOIN BUYTBL B
		ON U.USERID = B.USERID
	WHERE B.NUM IS NULL 
    ORDER BY U.USERID; 


SELECT *
	FROM USERTBL U 
	WHERE NOT EXISTS (SELECT USERID FROM BUYTBL) ; 
        
