-- 8
SELECT 
       WRITER_NM "�۰� �̸�"
     , "�� ��"
    FROM(SELECT
               WRITER_NO
             , COUNT(*) "�� ��"
             FROM TB_BOOK_AUTHOR
             GROUP BY  WRITER_NO
             ORDER BY 2 DESC)
    JOIN TB_WRITER USING(WRITER_NO)
    WHERE ROWNUM <= 3;
    