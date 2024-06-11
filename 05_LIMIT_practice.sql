-- EMPLOYEE 테이블에서 SALARY가 높은 순서대로 EMP_NAME과 SALARY를 포함하여 상위 5명의 데이터를 조회하시오.
SELECT EMP_NAME, SALARY
FROM employee
ORDER BY SALARY desc
LIMIT 5;

-- EMPLOYEE 테이블에서 HIRE_DATE가 가장 최근인 순서대로 EMP_NAME과 HIRE_DATE를 포함하여 상위 10명의 데이터를 조회하시오.
SELECT EMP_NAME, HIRE_DATE
FROM employee
ORDER BY HIRE_DATE desc
LIMIT 10;