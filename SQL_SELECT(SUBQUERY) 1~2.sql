-- 1. �μ��� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ���
-- �μ���, �μ��� �޿� �հ� ��ȸ
SELECT
       DEPT_TITLE �μ���
     , SUM(SALARY) "�μ��� �޿�"
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    GROUP BY DEPT_TITLE
    HAVING SUM(SALARY) > (SELECT
                               SUM(SALARY) * 0.2
                            FROM EMPLOYEE);

-- 2. ���� ���̺��� ���ʽ� ������ ������ ���� 5���� �����
-- ���, �̸�, �μ���, ���޸�, �Ի���, ���� ��ȸ
-- (ROWNUM, RANK() OVER �� �� ���)
SELECT
       EMP_ID ��� 
     , EMP_NAME �̸�
     , DEPT_TITLE �μ���
     , JOB_NAME ���޸�
     , HIRE_DATE �Ի���
     , ROWNUM ����
    FROM (SELECT
                   EMP_ID
                 , EMP_NAME
                 , DEPT_TITLE
                 , JOB_NAME
                 , HIRE_DATE
                 , RANK()OVER(ORDER BY (SALARY * (1 + NVL(BONUS, 0)) * 12) DESC)
                FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                LEFT JOIN JOB USING(JOB_CODE)
                ORDER BY (SALARY * (1 + NVL(BONUS, 0)) * 12) DESC)
 WHERE ROWNUM <= 5;




















