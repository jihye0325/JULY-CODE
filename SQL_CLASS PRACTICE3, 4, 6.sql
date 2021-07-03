-- 3.
SELECT
       DEPARTMENT_NAME �а���
     , STUDENT_NAME �̸�
     , TERM_NO �б�
     , POINT ����
     , RANK()OVER(ORDER BY POINT DESC) ���
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_GRADE USING(STUDENT_NO)
 WHERE TERM_NO = '200601'
    AND DEPARTMENT_NAME = '������а�'
 ORDER BY RANK()OVER(ORDER BY POINT DESC), 2;

-- 4.
SELECT
       �а���
     , "�а��� �������"
     , �����̸�
     --, ROWNUM
    FROM(SELECT
               DEPARTMENT_NAME �а���
             , ROUND(AVG(POINT), 2) "�а��� �������"
             , PROFESSOR_NAME �����̸�
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
       DEPARTMENT_NAME �а���
     , STUDENT_NAME �л��̸�
     , ROUND(AVG(POINT), 1) ����
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
-- 1999�⿡ �б��� �ٴ� �л��� �� 1�б� ������ ���� ���� �л����� ��ȸ�Ͻÿ�. (2,3�б�� ���� ���)
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

       












