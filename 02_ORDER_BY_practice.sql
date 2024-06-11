-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 오름차순 정렬하여 조회하시오.
SELECT *
FROM employee
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 내림차순 정렬하여 조회하시오.
SELECT *
FROM employee
ORDER BY SALARY DESC;

-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 내림차순 정렬하고, 같은 값이 있을 경우 EMP_NAME을 기준으로 오름차순 정렬하여 조회하시오.
SELECT *
FROM employee
ORDER BY SALARY DESC,
        EMP_NAME ASC;

-- EMPLOYEE 테이블에서 EMP_ID와 SALARY, 그 둘의 곱을 계산하여 multi_salary 별칭으로 부여하고,
-- 해당 값으로 내림차순 정렬하여 조회하시오.
SELECT EMP_ID * SALARY AS multi_salary
FROM employee
ORDER BY multi_salary DESC;

-- EMPLOYEE 테이블에서 ENT_YN이 'N'인 항목을 먼저, 'Y'인 항목을 나중에 정렬하여 조회하시오.
SELECT *
FROM employee
ORDER BY field(ENT_YN, 'N','Y');