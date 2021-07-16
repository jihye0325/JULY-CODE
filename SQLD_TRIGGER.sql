-- ��ǰ �԰�/��� ���� Ʈ���� ����(��� ����)
-- ��ǰ ���� ���̺�
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,   -- ��ǰ �ڵ�
    PNAME VARCHAR2(30),         -- ��ǰ��
    BRAND VARCHAR2(30),         -- �귣���
    PRICE NUMBER,               -- ����
    STOCK NUMBER DEFAULT 0      -- ���
);

-- ��ǰ ����� �� �̷� ���̺�
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,   -- �� �̷� �ڵ�
    PCODE NUMBER,               -- ��ǰ �ڵ�
    PDATE DATE,                 -- ��ǰ ��/�����
    AMOUNT NUMBER,              -- ��/��� ����
    STATUS VARCHAR2(10),        -- ��ǰ ����(�԰� OR ���)
    CHECK(STATUS IN('�԰�', '���')),
    FOREIGN KEY(PCODE) REFERENCES PRODUCT
);

-- �� ���̺��� PK�� �Ǿ��� ������ ����
CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

-- PRODUCT ���̺� ������ ����
INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������', '�Ｚ', 1200000, DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������', '����', 1300000, DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '�߱���', '������', 1400000, DEFAULT);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

-- PRO_DETAIL ���̺� ������ ����(INSERT) �� STATUS �÷� ���� ���� PRODUCT ���̺� STOCK �÷� �� ���� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON PRO_DETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰� �� ���
    IF :NEW.STATUS = '�԰�'   --> :NEW.STATUS : SQL �ݿ� �� STATUS ��
        THEN
            -- PRODUCT ���̺��� PCODE�� ���� ��ǰ�� ��� ����
            UPDATE PRODUCT
                SET STOCK = STOCK + :NEW.AMOUNT
              WHERE PCODE = :NEW.PCODE;
    END IF;

    IF :NEW.STATUS = '���'   --> :NEW.STATUS : SQL �ݿ� �� STATUS ��
        THEN
            -- PRODUCT ���̺��� PCODE�� ���� ��ǰ�� ��� ����
            UPDATE PRODUCT
                SET STOCK = STOCK - :NEW.AMOUNT
              WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- PCODE�� 5�� ��ǰ 5�� �԰�
INSERT INTO PRO_DETAIL
VALUES(SEQ_DCODE.NEXTVAL, 5, SYSDATE, 5, '�԰�');

SELECT * FROM PRO_DETAIL;

SELECT * FROM PRODUCT;

INSERT INTO PRO_DETAIL
VALUES(SEQ_DCODE.NEXTVAL, 6, SYSDATE, 10, '�԰�');

INSERT INTO PRO_DETAIL
VALUES(SEQ_DCODE.NEXTVAL, 7, SYSDATE, 20, '�԰�');

SELECT * FROM PRO_DETAIL;

SELECT * FROM PRODUCT;

INSERT INTO PRO_DETAIL
VALUES(SEQ_DCODE.NEXTVAL, 7, SYSDATE, 15, '���');
