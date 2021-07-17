-- 4
SELECT 
       WRITER_NM
     , OFFICE_TELNO
     , HOME_TELNO
     , MOBILE_NO
    FROM (SELECT 
                   WRITER_NM
                 , OFFICE_TELNO
                 , HOME_TELNO
                 , MOBILE_NO
                FROM TB_WRITER
             WHERE MOBILE_NO LIKE '019%'
                AND WRITER_NM LIKE '±è%'
             ORDER BY 1)
 WHERE ROWNUM = 1;
