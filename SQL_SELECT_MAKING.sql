/* 계정 : kh 
80년대생 이면서 이메일 _ 앞에 3글자가 있으며 보너스 포함 연봉이 과장보다 높은 직원의
이름, 부서명, 직급명, 지역명, 국가명, 보너스 포함 연봉을 조회하시오. */

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