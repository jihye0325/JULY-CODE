-- 1.
SELECT
       EMP_ID ���
     , EMP_NAME �̸�
     , ����
     , �ֹι�ȣ
     , �ٹ����
     , DEPT_TITLE �μ���
     , JOB_NAME ���޸�
     , ����
     , "���ʽ� ����"
     --, ROWNUM "����"
     , DECODE(ROWNUM, '1', '������ ������', '2', '�Ʊ���', '3', '�й��ϻ�') "������ �� �̸�"
    FROM (SELECT
                   EMP_ID 
                 , EMP_NAME 
                 , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) + 1 ����
                 , SUBSTR(EMP_NO, 1, 8)||'******' �ֹι�ȣ
                 , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
                 , DEPT_TITLE 
                 , JOB_NAME 
                 , TO_CHAR(SALARY * (1 + NVL(BONUS, 0)) * 12, 'L999,999,999') ����
                 , DECODE(BONUS, NULL, 'NO', 'YES') "���ʽ� ����"
                FROM EMPLOYEE
                JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                JOIN JOB USING(JOB_CODE)
                ORDER BY ���� DESC)
 WHERE ROWNUM <= 3
 ORDER BY ROWNUM;

-- 2.
SELECT
       RANK()OVER(ORDER BY �޿��� DESC) AS ����
     , DEPT_CODE
     , DEPT_TITLE
     , LOCAL_NAME
     , �޿���
    FROM (SELECT 
                   DEPT_CODE
                 , DEPT_TITLE
                 , LOCAL_NAME
                 , SUM(SALARY) �޿���
                FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
                GROUP BY DEPT_CODE, DEPT_TITLE, LOCAL_NAME
                ORDER BY SUM(SALARY) DESC)
 WHERE ROWNUM <= 5
 ORDER BY ROWNUM;

-- 5.
SELECT
       ���
     , �̸�
     , ���޸�
     , ����
     , �Ի�����
     , "������ �̸�"
     , ������
     , ������
     , ���޷���
     , �ּҿ���
     , �ִ����
     FROM (SELECT
                   E.EMP_ID ���
                 , E.EMP_NAME �̸�
                 , JOB_NAME "���޸�"
                 , E.SALARY ����
                 , E.HIRE_DATE �Ի�����
                 , NVL(M.EMP_NAME, '������ ����') "������ �̸�"
                 , NVL(LOCAL_NAME, '�ٹ����� ����') "������"
                 , NVL(NATIONAL_NAME, '�ٹ��� ����') "������"
                 , E.SAL_LEVEL "���޷���"
                 , MIN_SAL �ּҿ���
                 , MAX_SAL �ִ����
                 , RANK()OVER(ORDER BY FLOOR(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)/12) DESC)"�ټӼ���"
                FROM EMPLOYEE E, EMPLOYEE M, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
                WHERE E.MANAGER_ID = M.EMP_ID(+)
                    AND E.DEPT_CODE = D.DEPT_ID(+)
                    AND E.JOB_CODE = J.JOB_CODE
                    AND D.LOCATION_ID = L.LOCAL_CODE(+)
                    AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
                    AND E.SAL_LEVEL = S.SAL_LEVEL
                    AND SUBSTR(E.EMP_NO, 8, 1) = '1'
                    AND FLOOR(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)/12) >= 10
                    AND LOCAL_NAME LIKE 'ASIA%'
                    ORDER BY "�ټӼ���")
    WHERE "�ټӼ���" <= 3;
        

-- 7.
SELECT
       EMP_NAME �����
     , DEPT_TITLE �μ���
     , JOB_NAME ���޸�
     , LOCAL_NAME ������
     , NATIONAL_NAME ������
     , (SALARY * (1 + NVL(BONUS, 0))) * 12 "���ʽ����� ����"
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
 WHERE EMP_NO LIKE '8%'
    AND EMAIL LIKE '___^_%' ESCAPE '^'
    AND JOB_NAME != '����'
    AND SALARY * (1 + NVL(BONUS, 0)) * 12 > ANY (SELECT
                                                       (SALARY * (1 + NVL(BONUS, 0))) * 12
                                                      FROM EMPLOYEE
                                                      JOIN JOB USING(JOB_CODE)
                                                  WHERE JOB_NAME = '����')
 ORDER BY �����;










