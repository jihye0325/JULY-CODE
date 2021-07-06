-- SQL05_DML
-- 1.
INSERT INTO TB_CLASS_TYPE VALUES(01, '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES(02, '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES(03, '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES(04, '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES(05, '논문지도');

-- 2.
CREATE TABLE TB_학생일반정보
 AS SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소
    FROM TB_STUDENT;
-- 3.
CREATE TABLE TB_국어국문학과
 AS SELECT STUDENT_NO 학번
         , STUDENT_NAME 학생이름
         , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1 , 6), 'RRMMDD'), 'RRRR') 출생년도
         , PROFESSOR_NAME 교수이름
        FROM TB_STUDENT S
        LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
        LEFT JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    WHERE DEPARTMENT_NAME = '국어국문학과';
    
-- 4.
UPDATE TB_DEPARTMENT
    SET CAPACITY = ROUND(CAPACITY * 1.1, 0);

-- 5.
UPDATE TB_STUDENT
    SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
 WHERE STUDENT_NO = 'A413042'
    AND STUDENT_NAME = '박건우';
    
-- 6.
UPDATE TB_STUDENT
    SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

-- 7.
UPDATE TB_GRADE
    SET POINT = 3.5
 WHERE TERM_NO = '200501'
    AND (STUDENT_NO, CLASS_NO) IN (SELECT
                                        G.STUDENT_NO
                                      , G.CLASS_NO
                                    FROM TB_GRADE G
                                    JOIN TB_STUDENT S ON(G.STUDENT_NO = S.STUDENT_NO)
                                    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                                    JOIN TB_CLASS C ON(G.CLASS_NO = C.CLASS_NO)
                                     WHERE STUDENT_NAME = '김명훈'
                                         AND DEPARTMENT_NAME = '의학과'
                                         AND CLASS_NAME = '피부생리학');
-- 8.
UPDATE TB_GRADE
    SET POINT = NULL
 WHERE STUDENT_NO IN (SELECT
                            STUDENT_NO
                            FROM TB_STUDENT
                            WHERE ABSENCE_YN = 'Y');