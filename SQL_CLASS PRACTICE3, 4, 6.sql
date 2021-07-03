-- 3.
SELECT
       DEPARTMENT_NAME 학과명
     , STUDENT_NAME 이름
     , TERM_NO 학기
     , POINT 학점
     , RANK()OVER(ORDER BY POINT DESC) 등수
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_GRADE USING(STUDENT_NO)
 WHERE TERM_NO = '200601'
    AND DEPARTMENT_NAME = '국어국문학과'
 ORDER BY RANK()OVER(ORDER BY POINT DESC), 2;

-- 4.
SELECT
       학과명
     , "학과별 평균학점"
     , 교수이름
     --, ROWNUM
    FROM(SELECT
               DEPARTMENT_NAME 학과명
             , ROUND(AVG(POINT), 2) "학과별 평균학점"
             , PROFESSOR_NAME 교수이름
            FROM TB_DEPARTMENT
            JOIN TB_CLASS USING(DEPARTMENT_NO)
            JOIN TB_GRADE USING(CLASS_NO)
            JOIN TB_PROFESSOR USING(DEPARTMENT_NO)
         WHERE TERM_NO = '200401'
         GROUP BY DEPARTMENT_NAME, PROFESSOR_NAME
         ORDER BY 2 DESC)
 WHERE ROWNUM <= 3;



-- 6. 
SELECT
       DEPARTMENT_NAME 학과명
     , STUDENT_NAME 학생이름
     , ROUND(AVG(POINT), 1) 평점
    FROM TB_STUDENT
    JOIN (SELECT DEPARTMENT_NO
               , DEPARTMENT_NAME
               , AVG(POINT)
               FROM TB_STUDENT
               JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
               JOIN TB_GRADE USING(STUDENT_NO)
               WHERE SUBSTR(TERM_NO, 1, 1) ='2'
               GROUP BY DEPARTMENT_NO, DEPARTMENT_NAME, STUDENT_NO
               HAVING AVG(POINT) > 4
               ORDER BY DEPARTMENT_NAME, AVG(POINT) DESC) USING(DEPARTMENT_NO)
 JOIN TB_GRADE USING (STUDENT_NO)
 WHERE ABSENCE_YN = 'N'
 GROUP BY DEPARTMENT_NAME, STUDENT_NAME
 ORDER BY 1, 3 DESC;

-- 8.
-- 1999년에 학교를 다닌 학생들 중 1학기 점수가 가장 높은 학생들을 조회하시오. (2,3학기와 동점 허용)
SELECT
       STUDENT_NO
     , TERM_NO
     , POINT
     FROM TB_STUDENT
     JOIN TB_GRADE USING(STUDENT_NO)
    WHERE TERM_NO = '199901'
        AND (STUDENT_NO, POINT) IN (SELECT
                                        STUDENT_NO
                                      , MAX(POINT)
                                      FROM TB_STUDENT
                                      JOIN TB_GRADE USING(STUDENT_NO)
                                      WHERE SUBSTR(TERM_NO, 1, 4) = '1999'
                                      GROUP BY STUDENT_NO)
    ORDER BY 1;

       












