-- 6
SELECT 
       COMPOSE_TYPE "���� ����"
     , "��ϵ� ���� ����"
    FROM (SELECT
               COMPOSE_TYPE
             , COUNT(COMPOSE_TYPE) "��ϵ� ���� ����"
             FROM TB_BOOK_AUTHOR
            GROUP BY COMPOSE_TYPE
            ORDER BY 2 DESC)
 WHERE "��ϵ� ���� ����" >=300;
