-- 부서코드가 'D6' 이거나 'D8'인 직원의
-- 이름, 부서, 급여를 조회하세요
-- IN 연산자 : 비교하려는 값 목록에 일치하는 값이 있는지 확인
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM employee
WHERE DEPT_CODE IN ('D6','D8');

-- 이씨성이 아닌 직원의 사번, 이름, 이메일주소 조회
SELECT EMP_ID,EMP_NAME,EMAIL
FROM employee
WHERE EMP_NAME NOT LIKE '이%';

-- J2직급의 급여 200만원 이상 받는 직원이거나
-- J7 직급인 직원의 이름, 급여, 직급코드 조회
SELECT EMP_ID,SALARY,JOB_CODE
FROM employee
WHERE (JOB_CODE = 'J2' AND SALARY >= 2000000) OR
      (JOB_CODE = 'J7');

-- J7 직급이거나 J2 직급인 직원들 중
-- 급여가 200만원 이상인 직원의
-- 이름, 급여, 직급코드를 조회하세요
SELECT EMP_NAME,SALARY,JOB_CODE
FROM employee
WHERE (JOB_CODE = 'J2' OR JOB_CODE = 'J7') AND
      (SALARY >= 2000000);