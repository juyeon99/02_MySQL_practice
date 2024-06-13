-- 1. 학생이름과 주소지를 표시하시오.
--    단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME AS '학생 이름', STUDENT_ADDRESS AS '주소지'
FROM tb_student
ORDER BY STUDENT_NAME;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'Y'
ORDER BY DATE(SUBSTRING(CAST(STUDENT_SSN AS CHAR(14)), 1, 6)) DESC;

-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
--    단, 출력헤더에는 "학생이름","학번","거주지 주소" 가 출력되도록 한다.
SELECT STUDENT_NAME AS '학생이름',
       STUDENT_NO AS '학번',
       STUDENT_ADDRESS AS '거주지 주소'
FROM tb_student
WHERE (STUDENT_ADDRESS LIKE '%강원%' OR STUDENT_ADDRESS LIKE '%경기%') AND
      YEAR(ENTRANCE_DATE) >= 2020;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
--    (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM tb_professor
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM tb_department
                       WHERE DEPARTMENT_NAME = '법학과')
ORDER BY DATE(CONCAT('19',SUBSTRING(CAST(PROFESSOR_SSN AS CHAR(14)), 1, 6)));

-- 5. 2022년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다.
--    학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
SELECT STUDENT_NO, POINT
FROM tb_grade
WHERE TERM_NO = '202202' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_student JOIN tb_department USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM tb_class JOIN tb_department USING (DEPARTMENT_NO);

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT CLASS_NAME,PROFESSOR_NAME
FROM tb_class_professor JOIN tb_professor USING (PROFESSOR_NO)
                        JOIN tb_class USING (CLASS_NO)
ORDER BY CLASS_NAME;

-- 9. 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
--    이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT CLASS_NAME,PROFESSOR_NAME
FROM tb_class_professor JOIN tb_professor USING (PROFESSOR_NO)
                        JOIN tb_class USING (CLASS_NO)
WHERE tb_class.DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
                   FROM tb_department
                   WHERE CATEGORY = '인문사회')
ORDER BY CLASS_NAME;

-- 10. '음악학과' 학생들의 평점을 구하려고 한다.
--     음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
--     (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
SELECT STUDENT_NO AS '학번',
       STUDENT_NAME AS '학생 이름',
       ROUND(AVG(POINT),1) AS '전체 평점'
FROM tb_student JOIN tb_grade USING (STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM tb_department
                       WHERE DEPARTMENT_NAME = '음악학과')
GROUP BY STUDENT_NO
ORDER BY ROUND(AVG(POINT),1) DESC;

-- 11. 학번이 'A313047' 인 학생이 학교에 나오고 있지 않다.
--     지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
--     이때 사용할 SQL 문을 작성하시오.
--     단, 출력헤더는 학과이름, 학생이름, 지도교수이름으로 출력되도록 한다.
SELECT DEPARTMENT_NAME AS '학과이름',
       STUDENT_NAME AS '학생이름',
       PROFESSOR_NAME AS '지도교수이름'
FROM tb_student s JOIN tb_professor p ON s.COACH_PROFESSOR_NO = p.PROFESSOR_NO
                  JOIN tb_department d ON d.DEPARTMENT_NO = s.DEPARTMENT_NO
WHERE STUDENT_NO = 'A313047';


-- 12. 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
SELECT STUDENT_NAME, TERM_NO
FROM tb_student s JOIN tb_grade g ON s.STUDENT_NO = g.STUDENT_NO
WHERE SUBSTRING(TERM_NO,1,4) = '2022' AND
      g.CLASS_NO = (SELECT CLASS_NO
                    FROM tb_class
                    WHERE CLASS_NAME = '인간관계론');

-- 13. 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM tb_class JOIN tb_department USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
                        FROM tb_department
                        WHERE CATEGORY = '예체능') AND
      CLASS_NO NOT IN (SELECT CLASS_NO
                       FROM tb_class_professor);

-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
--     학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우 '지도교수 미지정'으로 표시하도록 하는 SQL 문을 작성하시오.
--     단, 출력헤더는 '학생이름', '지도교수'로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT STUDENT_NAME AS '학생이름',
       COALESCE(PROFESSOR_NAME, '지도교수 미지정') AS '지도교수'
FROM (tb_student s JOIN tb_department d USING (DEPARTMENT_NO))
                  LEFT JOIN tb_professor p ON p.PROFESSOR_NO = s.COACH_PROFESSOR_NO
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;

-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NO AS '학번',
       STUDENT_NAME AS '이름',
       DEPARTMENT_NAME AS '학과 이름',
       ROUND(AVG(POINT),1) AS '평점'
FROM tb_student JOIN tb_department USING (DEPARTMENT_NO)
                JOIN tb_grade USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO
HAVING ROUND(AVG(POINT),1) >= 4.0;

-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM tb_class JOIN tb_department USING (DEPARTMENT_NO)
              JOIN tb_grade USING (CLASS_NO)
WHERE DEPARTMENT_NAME = '환경조경학과' AND
      CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO;

-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM tb_student
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM tb_student
                       WHERE STUDENT_NAME = '최경희');

-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
SELECT AVG(POINT)-- STUDENT_NO, STUDENT_NAME
FROM tb_student JOIN tb_grade USING (STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM tb_department
                       WHERE DEPARTMENT_NAME = '국어국문학과')
GROUP BY STUDENT_NO;

SELECT MAX(average) -- ,STUDENT_NO,STUDENT_NAME
FROM (SELECT AVG(POINT) AS average, STUDENT_NO, STUDENT_NAME
      FROM tb_student JOIN tb_grade USING (STUDENT_NO)
      WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                             FROM tb_department
                             WHERE DEPARTMENT_NAME = '국어국문학과')
      GROUP BY STUDENT_NO) AS a;

-- 19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
--     단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.


