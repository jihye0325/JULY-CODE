-- SQL04_DDL
-- 1.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(20),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3.
ALTER TABLE TB_CATEGORY
ADD PRIMARY KEY(NAME);

-- 4.
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME NOT NULL;

-- 5.
ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

-- 6.
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7.
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT SYS_C007217 TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007215 TO PK_CLASS_TYPE_NAME;

-- 8.
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ', 'Y');
COMMIT;

-- 9.
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);