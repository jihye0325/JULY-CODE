-- 1.
DECLARE 
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE JOB.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, E.JOB_CODE, SALARY
        INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
        FROM EMPLOYEE E, JOB J
        WHERE E.JOB_CODE = J.JOB_CODE
            AND EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || DEPT_CODE); 
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
END;
/

-- 2.
DECLARE
    D DEPARTMENT%ROWTYPE;
BEGIN
    SELECT *
        INTO D
        FROM DEPARTMENT
        WHERE DEPT_ID = '&�μ��ڵ�';
    DBMS_OUTPUT.PUT_LINE('�μ� �ڵ� : ' || D.DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || D.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('���� �ڵ� : ' || D.LOCATION_ID);
END;
/

-- 3.
DECLARE
    MONTH NUMBER;
    QUARTER VARCHAR2(10);
BEGIN 
    MONTH := '&��';
    
    QUARTER := CASE MONTH
        WHEN '1' THEN '1�б�'
        WHEN '2' THEN '1�б�'
        WHEN '3' THEN '1�б�'
        WHEN '4' THEN '2�б�'
        WHEN '5' THEN '2�б�'
        WHEN '6' THEN '2�б�'
        WHEN '7' THEN '3�б�'
        WHEN '8' THEN '3�б�'
        WHEN '9' THEN '3�б�'
        WHEN '10' THEN '4�б�'
        WHEN '11' THEN '4�б�'
        WHEN '12' THEN '4�б�'
        ELSE '�߸��� ���� �Է�'
    END;
    
    DBMS_OUTPUT.PUT_LINE(MONTH || '���� ' || QUARTER || '�Դϴ�.');
END;
/
            
-- 4.
DECLARE
    E EMPLOYEE%ROWTYPE;
    JOB_NAME VARCHAR2(10);
BEGIN
    SELECT *
        INTO E
        FROM EMPLOYEE
      WHERE EMP_ID = '&�����ȣ';
    
    JOB_NAME := CASE E.JOB_CODE
        WHEN 'J1' THEN '��ǥ'
        WHEN 'J2' THEN '�λ���'
        WHEN 'J3' THEN '����'
        WHEN 'J4' THEN '����'
        WHEN 'J5' THEN '����'
        WHEN 'J6' THEN '�븮'
        WHEN 'J7' THEN '���'
      END;
      
      DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
      DBMS_OUTPUT.PUT_LINE('�̸� : ' || E.EMP_NAME);
      DBMS_OUTPUT.PUT_LINE('���޸� : ' || JOB_NAME);
END;
/

-- 5.
DECLARE 
    E EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN 
    SELECT *
        INTO E
        FROM EMPLOYEE
      WHERE EMP_ID = '&���';
      
      DBMS_OUTPUT.PUT_LINE('���� : ' || E.SALARY);
      DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
      
      IF(E.BONUS IS NOT NULL)
        THEN YSALARY := E.SALARY * (1 + E.BONUS) * 12;
      ELSE YSALARY := E.SALARY * 12;
      END IF;
    
      DBMS_OUTPUT.PUT_LINE('����: ' || YSALARY);
END;
/
    