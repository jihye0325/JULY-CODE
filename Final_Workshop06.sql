-- 6
SELECT 
       COMPOSE_TYPE "저작 형태"
     , "등록된 도서 수량"
    FROM (SELECT
               COMPOSE_TYPE
             , COUNT(COMPOSE_TYPE) "등록된 도서 수량"
             FROM TB_BOOK_AUTHOR
            GROUP BY COMPOSE_TYPE
            ORDER BY 2 DESC)
 WHERE "등록된 도서 수량" >=300;
