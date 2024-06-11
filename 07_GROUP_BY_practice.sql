-- EMPLOYEE 테이블에서 JOB_CODE별 평균 급여를 조회하시오.
SELECT AVG(SALARY),JOB_CODE
FROM employee
GROUP BY JOB_CODE;

-- EMPLOYEE 테이블에서 SAL_LEVEL별 최소 급여를 조회하시오.
SELECT MIN(SALARY),SAL_LEVEL
FROM employee
GROUP BY SAL_LEVEL;

-- EMPLOYEE 테이블에서 DEPT_CODE별 직원 수를 조회하되, 직원 수가 3명 이상인 부서만 조회하시오.
SELECT DEPT_CODE,COUNT(*)
FROM employee
GROUP BY DEPT_CODE
HAVING COUNT(*) >= 3;

-- EMPLOYEE 테이블에서 JOB_CODE별 평균 급여를 조회하되, 평균 급여가 4000000 이상인 직급만 조회하시오.
SELECT JOB_CODE,AVG(SALARY)
FROM employee
GROUP BY JOB_CODE
HAVING AVG(SALARY) >= 4000000;

-- EMPLOYEE 테이블에서 DEPT_CODE와 JOB_CODE별 총 급여와 각 DEPT_CODE별 총 급여를 ROLLUP을 사용하여 조회하시오.
SELECT DEPT_CODE,
       JOB_CODE,
       SUM(SALARY) 'TOTAL_SALARY'   -- DEPT_CODE와 JOB_CODE별 총 급여
#        ,(SELECT SUM(SALARY)
#         FROM employee e1
#         GROUP BY DEPT_CODE
#         HAVING e1.DEPT_CODE = e2.DEPT_CODE) '각 DEPT_CODE별 총 급여'
FROM employee e2
GROUP BY DEPT_CODE,JOB_CODE
WITH ROLLUP;