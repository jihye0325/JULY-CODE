-- 1. 부서별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의
-- 부서명, 부서별 급여 합계 조회
SELECT
       DEPT_TITLE 부서명
     , SUM(SALARY) "부서별 급여"
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    GROUP BY DEPT_TITLE
    HAVING SUM(SALARY) > (SELECT
                               SUM(SALARY) * 0.2
                            FROM EMPLOYEE);

-- 2. 직원 테이블에서 보너스 포함한 연봉이 높은 5명의 사원을
-- 사번, 이름, 부서명, 직급명, 입사일, 순위 조회
-- (ROWNUM, RANK() OVER 둘 다 사용)
SELECT
       EMP_ID 사번 
     , EMP_NAME 이름
     , DEPT_TITLE 부서명
     , JOB_NAME 직급명
     , HIRE_DATE 입사일
     , ROWNUM 순위
    FROM (SELECT
                   EMP_ID
                 , EMP_NAME
                 , DEPT_TITLE
                 , JOB_NAME
                 , HIRE_DATE
                 , RANK()OVER(ORDER BY (SALARY * (1 + NVL(BONUS, 0)) * 12) DESC)
                FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                LEFT JOIN JOB USING(JOB_CODE)
                ORDER BY (SALARY * (1 + NVL(BONUS, 0)) * 12) DESC)
 WHERE ROWNUM <= 5;




















