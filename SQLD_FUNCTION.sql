-- 사번을 입력받아 해당 사원의 연봉을 계산하고 리턴하는 함수 
CREATE OR REPLACE FUNCTION BONUS_CALC
    (V_EMP_ID EMPLOYEE.EMP_ID%TYPE) -- 매개변수
RETURN NUMBER 
IS 
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS, 0)
        INTO V_SAL, V_BONUS
        FROM EMPLOYEE
      WHERE EMP_ID = V_EMP_ID;  -- 매개변수로 아이디를 조회해서 월급, 보너스를 조회해옴
      
      CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
      
      RETURN CALC_SAL;
END;
/

-- 함수 결과를 반환 받아 저장할 바인드 변수 선언
VAR VAR_CALC NUMBER;

-- 반환 값 처리하여 함수 호출
EXEC :VAR_CALC := BONUS_CALC('&사번');



