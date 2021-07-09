-- 6. FOR LOOP�� ������ ¦���ܸ� ���
-- �ݺ��� �ȿ� ���ǹ�
DECLARE
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0  --> ¦���� ���(2�� ���� �������� 0)
            THEN FOR SU IN 1..9
                 LOOP 
                     RESULT := DAN * SU;
                     DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || ' = ' || RESULT);
                 END LOOP;
                 
                 DBMS_OUTPUT.PUT_LINE(' '); --> �� �ܸ��� ����ó��
        END IF;
    END LOOP;
END;
/

-- 7. WHILE LOOP�� Ȧ���� �������� ���� ���
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

-- 1. EMPLOYEE ���̺��� �̸����� �˻��Ͽ� �̸��� �μ���� �������� ������ ��� ���
-- ��, �̸��� �ش��ϴ� ����� ������ ����ó���ο��� '�Է��Ͻ� �̸��� �ش��ϴ� ����� �����ϴ�.'
-- ��� ��� (�ý��� ���� - NO_DATA_FOUND)
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
            WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME || ' DEPT_TITLE : ' 
                || DEPT_TITLE || ' LOCAL_NAME : ' || LOCAL_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�Է��Ͻ� �̸��� �ش��ϴ� ����� �����ϴ�.');
END;
/

-- 2. ���̸� �Է� �ް� �Է� ���� ���̰� 20�� �̻��̸� ���� �����մϴٸ� ���
-- 20�̸��̸� UNDER_TWENTY��� ���� �߻����Ѽ� 20�� �̸��� ���� �Ұ��մϴٸ� ���
-- (����� ���� ����)
DECLARE
    AGE NUMBER;
    UNDER_TWENTY EXCEPTION;
    PRAGMA EXCEPTION_INIT(UNDER_TWENTY, -00002);
BEGIN
    AGE := '&�����Է�';
    
    IF AGE < 20
        THEN RAISE UNDER_TWENTY;
    ELSE
        DBMS_OUTPUT.PUT_LINE('���� �����մϴ�');
    END IF;
EXCEPTION
    WHEN UNDER_TWENTY THEN DBMS_OUTPUT.PUT_LINE('20�� �̸��� ���� �Ұ��մϴ�');
END;
/
    
    
    
























