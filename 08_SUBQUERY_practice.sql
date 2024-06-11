-- EMPLOYEE 테이블에서 '해외영업1부'에 속한 모든 직원의 이름, 직급, 급여를 조회하시오.
SELECT EMP_NAME,JOB_NAME,SALARY
FROM employee e, job
WHERE JOB_NAME = (SELECT JOB_NAME
                  FROM job
                  WHERE e.JOB_CODE = JOB_CODE) AND
    e.DEPT_CODE = (SELECT DEPT_ID
                  FROM department
                  WHERE DEPT_TITLE = '해외영업1부');

-- EMPLOYEE 테이블에서 모든 직원의 평균 급여보다 높은 급여를 받는 직원의 이름과 급여를 조회하시오.
SELECT EMP_NAME,SALARY
FROM employee e
WHERE SALARY >= (SELECT AVG(SALARY)
                  FROM employee);

-- EMPLOYEE 테이블에서 각 부서의 평균 급여보다 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM employee e
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM employee
                 GROUP BY DEPT_CODE
                 HAVING e.DEPT_CODE = DEPT_CODE);

-- 상관 서브쿼리 문제
-- EMPLOYEE 테이블에서 각 부서별로 가장 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
SELECT e1.EMP_NAME,d.DEPT_TITLE,e1.SALARY
FROM employee e1 JOIN department d ON e1.DEPT_CODE = d.DEPT_ID
WHERE SALARY = (SELECT MAX(SALARY)
                 FROM employee e2
                 GROUP BY DEPT_CODE
                 HAVING e1.DEPT_CODE = e2.DEPT_CODE);

-- EMPLOYEE 테이블에서 각 직급별 평균 급여보다 높은 급여를 받는 직원의 이름, 직급, 급여를 조회하시오.
SELECT e1.EMP_NAME,d.DEPT_TITLE,e1.SALARY
FROM employee e1 JOIN department d ON e1.DEPT_CODE = d.DEPT_ID
WHERE SALARY > (SELECT AVG(SALARY)
                 FROM employee e2
                 GROUP BY DEPT_CODE
                 HAVING e1.DEPT_CODE = e2.DEPT_CODE);

-- EXISTS 절 문제
-- DEPARTMENT 테이블에서 직원이 있는 부서의 부서명을 조회하시오.
SELECT DISTINCT DEPT_TITLE
FROM employee e JOIN department d ON d.DEPT_ID = e.DEPT_CODE
WHERE EXISTS(SELECT e.EMP_NAME
             FROM employee e
             GROUP BY DEPT_CODE);

-- EMPLOYEE 테이블에서 급여가 가장 높은 직원의 이름과 급여를 조회하시오. (NOT EXISTS 사용)
SELECT EMP_NAME,SALARY
FROM employee e1
WHERE NOT EXISTS(SELECT SALARY
                 FROM employee e2
                 WHERE e1.SALARY < e2.SALARY);

-- CTE 문제
-- EMPLOYEE 테이블에서 각 부서별 평균 급여를 계산하고,
-- 평균 급여가 4000000 이상인 부서의 부서명과 평균 급여를 조회하시오.
WITH emp_cte AS (
    SELECT DEPT_TITLE, AVG(SALARY)
    FROM employee JOIN department ON DEPT_CODE = DEPT_ID
    GROUP BY DEPT_CODE
)
SELECT *
FROM emp_cte;