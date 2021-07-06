-- SQL05_DML
-- 1.
INSERT INTO TB_CLASS_TYPE VALUES(01, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES(02, '��������');
INSERT INTO TB_CLASS_TYPE VALUES(03, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES(04, '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES(05, '������');

-- 2.
CREATE TABLE TB_�л��Ϲ�����
 AS SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS �ּ�
    FROM TB_STUDENT;
-- 3.
CREATE TABLE TB_������а�
 AS SELECT STUDENT_NO �й�
         , STUDENT_NAME �л��̸�
         , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1 , 6), 'RRMMDD'), 'RRRR') ����⵵
         , PROFESSOR_NAME �����̸�
        FROM TB_STUDENT S
        LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
        LEFT JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    WHERE DEPARTMENT_NAME = '������а�';
    
-- 4.
UPDATE TB_DEPARTMENT
    SET CAPACITY = ROUND(CAPACITY * 1.1, 0);

-- 5.
UPDATE TB_STUDENT
    SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
 WHERE STUDENT_NO = 'A413042'
    AND STUDENT_NAME = '�ڰǿ�';
    
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
                                     WHERE STUDENT_NAME = '�����'
                                         AND DEPARTMENT_NAME = '���а�'
                                         AND CLASS_NAME = '�Ǻλ�����');
-- 8.
UPDATE TB_GRADE
    SET POINT = NULL
 WHERE STUDENT_NO IN (SELECT
                            STUDENT_NO
                            FROM TB_STUDENT
                            WHERE ABSENCE_YN = 'Y');