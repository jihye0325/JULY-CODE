-- 5
SELECT
       COUNT(*) "�۰�(��)"
    FROM(SELECT
               DISTINCT WRITER_NO
            FROM TB_BOOK_AUTHOR
         WHERE COMPOSE_TYPE = '�ű�');