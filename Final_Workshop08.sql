-- 8
SELECT 
       WRITER_NM "작가 이름"
     , "권 수"
    FROM(SELECT
               WRITER_NO
             , COUNT(*) "권 수"
             FROM TB_BOOK_AUTHOR
             GROUP BY  WRITER_NO
             ORDER BY 2 DESC)
    JOIN TB_WRITER USING(WRITER_NO)
    WHERE ROWNUM <= 3;
    