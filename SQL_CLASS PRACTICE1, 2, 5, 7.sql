-- 1.
SELECT
       EMP_ID 사번
     , EMP_NAME 이름
     , 나이
     , 주민번호
     , 근무년수
     , DEPT_TITLE 부서명
     , JOB_NAME 직급명
     , 연봉
     , "보너스 여부"
     --, ROWNUM "순위"
     , DECODE(ROWNUM, '1', '올해의 연봉상', '2', '아깝상', '3', '분발하상') "순위별 상 이름"
    FROM (SELECT
                   EMP_ID 
                 , EMP_NAME 
                 , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) + 1 나이
                 , SUBSTR(EMP_NO, 1, 8)||'******' 주민번호
                 , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
                 , DEPT_TITLE 
                 , JOB_NAME 
                 , TO_CHAR(SALARY * (1 + NVL(BONUS, 0)) * 12, 'L999,999,999') 연봉
                 , DECODE(BONUS, NULL, 'NO', 'YES') "보너스 여부"
                FROM EMPLOYEE
                JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                JOIN JOB USING(JOB_CODE)
                ORDER BY 연봉 DESC)
 WHERE ROWNUM <= 3
 ORDER BY ROWNUM;

-- 2.
SELECT
       RANK()OVER(ORDER BY 급여합 DESC) AS 순위
     , DEPT_CODE
     , DEPT_TITLE
     , LOCAL_NAME
     , 급여합
    FROM (SELECT 
                   DEPT_CODE
                 , DEPT_TITLE
                 , LOCAL_NAME
                 , SUM(SALARY) 급여합
                FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
                GROUP BY DEPT_CODE, DEPT_TITLE, LOCAL_NAME
                ORDER BY SUM(SALARY) DESC)
 WHERE ROWNUM <= 5
 ORDER BY ROWNUM;

-- 5.
SELECT
       사번
     , 이름
     , 직급명
     , 월급
     , 입사일자
     , "관리자 이름"
     , 국가명
     , 지역명
     , 월급레벨
     , 최소월급
     , 최대월급
     FROM (SELECT
                   E.EMP_ID 사번
                 , E.EMP_NAME 이름
                 , JOB_NAME "직급명"
                 , E.SALARY 월급
                 , E.HIRE_DATE 입사일자
                 , NVL(M.EMP_NAME, '관리자 미정') "관리자 이름"
                 , NVL(LOCAL_NAME, '근무국가 미정') "국가명"
                 , NVL(NATIONAL_NAME, '근무지 미정') "지역명"
                 , E.SAL_LEVEL "월급레벨"
                 , MIN_SAL 최소월급
                 , MAX_SAL 최대월급
                 , RANK()OVER(ORDER BY FLOOR(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)/12) DESC)"근속순위"
                FROM EMPLOYEE E, EMPLOYEE M, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
                WHERE E.MANAGER_ID = M.EMP_ID(+)
                    AND E.DEPT_CODE = D.DEPT_ID(+)
                    AND E.JOB_CODE = J.JOB_CODE
                    AND D.LOCATION_ID = L.LOCAL_CODE(+)
                    AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
                    AND E.SAL_LEVEL = S.SAL_LEVEL
                    AND SUBSTR(E.EMP_NO, 8, 1) = '1'
                    AND FLOOR(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)/12) >= 10
                    AND LOCAL_NAME LIKE 'ASIA%'
                    ORDER BY "근속순위")
    WHERE "근속순위" <= 3;
        

-- 7.
SELECT
       EMP_NAME 사원명
     , DEPT_TITLE 부서명
     , JOB_NAME 직급명
     , LOCAL_NAME 지역명
     , NATIONAL_NAME 국가명
     , (SALARY * (1 + NVL(BONUS, 0))) * 12 "보너스포함 연봉"
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
 WHERE EMP_NO LIKE '8%'
    AND EMAIL LIKE '___^_%' ESCAPE '^'
    AND JOB_NAME != '과장'
    AND SALARY * (1 + NVL(BONUS, 0)) * 12 > ANY (SELECT
                                                       (SALARY * (1 + NVL(BONUS, 0))) * 12
                                                      FROM EMPLOYEE
                                                      JOIN JOB USING(JOB_CODE)
                                                  WHERE JOB_NAME = '과장')
 ORDER BY 사원명;










