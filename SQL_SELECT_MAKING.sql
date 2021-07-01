/* ���� : kh 
80���� �̸鼭 �̸��� _ �տ� 3���ڰ� ������ ���ʽ� ���� ������ ���庸�� ���� ������
�̸�, �μ���, ���޸�, ������, ������, ���ʽ� ���� ������ ��ȸ�Ͻÿ�. */

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