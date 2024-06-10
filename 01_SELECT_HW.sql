-- DEPARTMENT 테이블에서 모든 컬럼을 조회하시오.
SELECT *
FROM department;

-- EMPLOYEE 테이블에서 EMP_NAME과 SALARY 컬럼을 조회하시오.
SELECT EMP_NAME,SALARY
FROM employee;

-- JOB 테이블에서 JOB_CODE와 JOB_NAME을 조회하시오.
SELECT JOB_CODE,JOB_NAME
FROM job;

-- LOCATION 테이블에서 LOCAL_CODE와 LOCAL_NAME을 조회하시오.
SELECT LOCAL_CODE,LOCAL_NAME
FROM location;

-- NATION 테이블에서 NATIONAL_NAME의 별칭을 '국가명'으로 하여 조회하시오.
SELECT NATIONAL_NAME AS '국가명'
FROM nation;