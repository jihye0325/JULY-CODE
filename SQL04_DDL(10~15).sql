-- 10.
GRANT CREATE VIEW TO hw;

CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO 학번
        , STUDENT_NAME 학생이름
        , STUDENT_ADDRESS 주소
    FROM TB_STUDENT;

-- 11.
CREATE OR REPLACE VIEW VW_지도면담
AS SELECT STUDENT_NAME 학생이름
        , DEPARTMENT_NAME 학과이름
        , PROFESSOR_NAME 지도교수이름
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO);

-- 12.
CREATE OR REPLACE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME 
        , STUDENT_COUNT
    FROM (SELECT DEPARTMENT_NO
               , COUNT(DEPARTMENT_NO) "STUDENT_COUNT"
             FROM TB_STUDENT
            GROUP BY DEPARTMENT_NO
            ORDER BY 1)
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);
    
-- 13.
UPDATE VW_학생일반정보
    SET 학생이름 = '성지혜'
 WHERE 학번 = 'A213046';

-- 14.
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO 학번
        , STUDENT_NAME 학생이름
        , STUDENT_ADDRESS 주소
    FROM TB_STUDENT
    WITH READ ONLY;  
    
-- 15.
SELECT 
       CLASS_NO "과목번호"
     , CLASS_NAME "과목이름"
     , "누적수강생수(명)"
     FROM (SELECT  
                G.CLASS_NO
              , C.CLASS_NAME
              , COUNT(G.CLASS_NO) "누적수강생수(명)"
              FROM TB_GRADE G
              JOIN TB_CLASS C ON(G.CLASS_NO = C.CLASS_NO)
              WHERE SUBSTR(TERM_NO, 1, 4) >= 2005
              GROUP BY G.CLASS_NO, C.CLASS_NAME
              ORDER BY 3 DESC)
    WHERE ROWNUM <= 3;


