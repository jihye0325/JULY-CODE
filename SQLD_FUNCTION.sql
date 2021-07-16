-- ����� �Է¹޾� �ش� ����� ������ ����ϰ� �����ϴ� �Լ� 
CREATE OR REPLACE FUNCTION BONUS_CALC
    (V_EMP_ID EMPLOYEE.EMP_ID%TYPE) -- �Ű�����
RETURN NUMBER 
IS 
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS, 0)
        INTO V_SAL, V_BONUS
        FROM EMPLOYEE
      WHERE EMP_ID = V_EMP_ID;  -- �Ű������� ���̵� ��ȸ�ؼ� ����, ���ʽ��� ��ȸ�ؿ�
      
      CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
      
      RETURN CALC_SAL;
END;
/

-- �Լ� ����� ��ȯ �޾� ������ ���ε� ���� ����
VAR VAR_CALC NUMBER;

-- ��ȯ �� ó���Ͽ� �Լ� ȣ��
EXEC :VAR_CALC := BONUS_CALC('&���');



