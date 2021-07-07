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
            AND EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || DEPT_CODE); 
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
END;
/

-- 2.
DECLARE
    D DEPARTMENT%ROWTYPE;
BEGIN
    SELECT *
        INTO D
        FROM DEPARTMENT
        WHERE DEPT_ID = '&부서코드';
    DBMS_OUTPUT.PUT_LINE('부서 코드 : ' || D.DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || D.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('지역 코드 : ' || D.LOCATION_ID);
END;
/

-- 3.
DECLARE
    MONTH NUMBER;
    QUARTER VARCHAR2(10);
BEGIN 
    MONTH := '&월';
    
    QUARTER := CASE MONTH
        WHEN '1' THEN '1분기'
        WHEN '2' THEN '1분기'
        WHEN '3' THEN '1분기'
        WHEN '4' THEN '2분기'
        WHEN '5' THEN '2분기'
        WHEN '6' THEN '2분기'
        WHEN '7' THEN '3분기'
        WHEN '8' THEN '3분기'
        WHEN '9' THEN '3분기'
        WHEN '10' THEN '4분기'
        WHEN '11' THEN '4분기'
        WHEN '12' THEN '4분기'
        ELSE '잘못된 숫자 입력'
    END;
    
    DBMS_OUTPUT.PUT_LINE(MONTH || '월은 ' || QUARTER || '입니다.');
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
      WHERE EMP_ID = '&사원번호';
    
    JOB_NAME := CASE E.JOB_CODE
        WHEN 'J1' THEN '대표'
        WHEN 'J2' THEN '부사장'
        WHEN 'J3' THEN '부장'
        WHEN 'J4' THEN '차장'
        WHEN 'J5' THEN '과장'
        WHEN 'J6' THEN '대리'
        WHEN 'J7' THEN '사원'
      END;
      
      DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID);
      DBMS_OUTPUT.PUT_LINE('이름 : ' || E.EMP_NAME);
      DBMS_OUTPUT.PUT_LINE('직급명 : ' || JOB_NAME);
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
      WHERE EMP_ID = '&사번';
      
      DBMS_OUTPUT.PUT_LINE('월급 : ' || E.SALARY);
      DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
      
      IF(E.BONUS IS NOT NULL)
        THEN YSALARY := E.SALARY * (1 + E.BONUS) * 12;
      ELSE YSALARY := E.SALARY * 12;
      END IF;
    
      DBMS_OUTPUT.PUT_LINE('연봉: ' || YSALARY);
END;
/
    