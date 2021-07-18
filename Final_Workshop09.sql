-- 9
UPDATE TB_WRITER T
    SET REGIST_DATE = (SELECT
                            MIN(ISSUE_DATE)
                            FROM TB_WRITER W
                            JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
                            JOIN TB_BOOK USING(BOOK_NO)
                            WHERE T.WRITER_NM = W.WRITER_NM
                            GROUP BY WRITER_NM);
COMMIT;
