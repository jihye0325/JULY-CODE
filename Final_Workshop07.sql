-- 7
SELECT 
       BOOK_NM
     , ISSUE_DATE
     , PUBLISHER_NM
    FROM (SELECT
                BOOK_NM
              , ISSUE_DATE
              , PUBLISHER_NM
              FROM TB_BOOK
              ORDER BY 2 DESC)
 WHERE ROWNUM = 1;
