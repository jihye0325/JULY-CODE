-- 10.
GRANT CREATE VIEW TO hw;

CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO �й�
        , STUDENT_NAME �л��̸�
        , STUDENT_ADDRESS �ּ�
    FROM TB_STUDENT;

-- 11.
CREATE OR REPLACE VIEW VW_�������
AS SELECT STUDENT_NAME �л��̸�
        , DEPARTMENT_NAME �а��̸�
        , PROFESSOR_NAME ���������̸�
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO);

-- 12.
CREATE OR REPLACE VIEW VW_�а����л���
AS SELECT DEPARTMENT_NAME 
        , STUDENT_COUNT
    FROM (SELECT DEPARTMENT_NO
               , COUNT(DEPARTMENT_NO) "STUDENT_COUNT"
             FROM TB_STUDENT
            GROUP BY DEPARTMENT_NO
            ORDER BY 1)
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);
    
-- 13.
UPDATE VW_�л��Ϲ�����
    SET �л��̸� = '������'
 WHERE �й� = 'A213046';

-- 14.
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO �й�
        , STUDENT_NAME �л��̸�
        , STUDENT_ADDRESS �ּ�
    FROM TB_STUDENT
    WITH READ ONLY;  
    
-- 15.
SELECT 
       CLASS_NO "�����ȣ"
     , CLASS_NAME "�����̸�"
     , "������������(��)"
     FROM (SELECT  
                G.CLASS_NO
              , C.CLASS_NAME
              , COUNT(G.CLASS_NO) "������������(��)"
              FROM TB_GRADE G
              JOIN TB_CLASS C ON(G.CLASS_NO = C.CLASS_NO)
              WHERE SUBSTR(TERM_NO, 1, 4) >= 2005
              GROUP BY G.CLASS_NO, C.CLASS_NAME
              ORDER BY 3 DESC)
    WHERE ROWNUM <= 3;


