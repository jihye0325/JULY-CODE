-- 6. FOR LOOP로 구구단 짝수단만 출력
-- 반복문 안에 조건문
DECLARE
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0  --> 짝수일 경우(2로 나눈 나머지가 0)
            THEN FOR SU IN 1..9
                 LOOP 
                     RESULT := DAN * SU;
                     DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || ' = ' || RESULT);
                 END LOOP;
                 
                 DBMS_OUTPUT.PUT_LINE(' '); --> 각 단마다 개행처리
        END IF;
    END LOOP;
END;
/

-- 7. WHILE LOOP로 홀수가 곱해지는 수만 출력
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 3;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        WHILE SU <= 9
        LOOP 
            IF MOD(SU, 2) = 1 THEN
                RESULT := DAN *SU;
                DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || ' = ' || RESULT);
            END IF;
            SU := SU + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');
        DAN := DAN + 1;
    END LOOP;
END;
/

-- 1. EMPLOYEE 테이블에서 이름으로 검색하여 이름과 부서명과 지역명을 변수에 담아 출력
-- 단, 이름에 해당하는 사원이 없으면 예외처리부에서 '입력하신 이름에 해당하는 사원이 없습니다.'
-- 라고 출력 (시스템 예외 - NO_DATA_FOUND)
DECLARE
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    LOCAL_NAME LOCATION.LOCAL_NAME%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
        INTO EMP_NAME, DEPT_TITLE, LOCAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
            WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME || ' DEPT_TITLE : ' 
                || DEPT_TITLE || ' LOCAL_NAME : ' || LOCAL_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('입력하신 이름에 해당하는 사원이 없습니다.');
END;
/

-- 2. 나이를 입력 받고 입력 받은 나이가 20세 이상이면 입장 가능합니다를 출력
-- 20미만이면 UNDER_TWENTY라는 예외 발생시켜서 20세 미만은 입장 불가합니다를 출력
-- (사용자 정의 예외)
DECLARE
    AGE NUMBER;
    UNDER_TWENTY EXCEPTION;
    PRAGMA EXCEPTION_INIT(UNDER_TWENTY, -00002);
BEGIN
    AGE := '&나이입력';
    
    IF AGE < 20
        THEN RAISE UNDER_TWENTY;
    ELSE
        DBMS_OUTPUT.PUT_LINE('입장 가능합니다');
    END IF;
EXCEPTION
    WHEN UNDER_TWENTY THEN DBMS_OUTPUT.PUT_LINE('20세 미만은 입장 불가합니다');
END;
/
    
    
    
























