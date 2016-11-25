-- 1. 문자처리 함수
--student 테이블을 사용하여 주전공이 201번인 학생들의 ID를
--첫 글자만 대문자로 출력
--[1] initcap(필드명)
select id from student;
select id, initcap(id) as "첫글자 대문자로" from student
where deptno1=201;

--STUDENT 테이블에서 주전공이 201번인 학생들의 ID를
--소문자, 대문자로 출력
--[2] lower(필드명), upper(필드명)
select id, lower(id), upper(id) from student
where deptno1=201;

--STUDENT 테이블에서 ID가 9글자 이상인 학생들의
-- 이름과 ID와 글자수 출력
--[3] length(필드명)
select name, id, length(id) from student
where length(id)>=9;

--STUDENT 테이블에서 주전공이 201번인 학생들의 이름과
-- 이름의 글자수, 이름의 바이트 수를 출력
-- 한글의 경우 한 글자의 2~3바이트, 영어는 한 글자의 1byte
--[4] lengthb(필드명)
select name, length(name), lengthb(name) from student
where deptno1=201;

--PROFESSOR 테이블에서 교수들의 이름과 직급 출력
--[5] concat(필드명1, 필드명2)
select name || position, concat(name,position)
from professor;

--student 테이블에서 JUMIN 칼럼을 사용하여 주전공이
--101번인 학생들의 이름과 생년월일을 출력
--[6] substr(컬럼명, start, size)
select name, birthday, jumin, substr(jumin, 1, 6)
from student where deptno1=101;


-- 2. 숫자처리 함수
--round()함수 - 반올림
select 12.345, round(12.345, 2), round(17.345, -1)
from dual;
select 12.345, trunc(12.345, 2), trunc(17.345, -1)
from dual;

-- mod() 함수 - 나머지 값 계산
select * from professor where mod(deptno,2)=0;
-- 학과코드가 짝수인 레코드 검색


--log() 함수 : e=2.71828183
select log(2,8) from dual;  -- log2 8
select log(2.71828183,8) from dual; -loge 8 자연로그

--exp() 함수
select exp(2.07944) from dual; --7.99998

-- 3. 날짜처리 함수
--sysdate : 현재날짜와 시간
select sysdate from dual; -- dummy테이블

--professor 테이블에서 입사후 1년이 되는 날짜?
-- 형식) add_months(필드명, 월수)
select hiredate, add_months(hiredate, 12) from professor;

/*
 * - 형변환 관련 함수
 *1. to_char(): 날짜, 숫자 -> 문자형 변환
 *2. to_date(): 숫자, 문자열 -> 날짜형 변환
 *3. to_number(): 특정 문자 -> 숫자형 변환
 */
-- 4. 형변환 함수
--날짜를 문자로 변환
select sysdate, to_char(sysdate),
to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;
-- 숫자를 문자로 변환
select to_char(200000, 'L999,999') from dual;
-- 날짜 형식으로 변환
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE=TO_DATE(19810220,'YYYY/MM/DD'); --'YYYYMMDD','YYYY-MM-DD','YYYY/MM/DD'
-- 숫자 형식으로 변환
SELECT TO_NUMBER('20,000', '99,999')-TO_NUMBER('10,000', '99,999')
FROM DUAL;

--Professor 테이블을 참조하여 101번 학과 교수 이름과 연봉 출력하기
--단 연봉은 (pay*12)+bonus로 계산하고 천 단위 기호 표시
select name,(pay*12)+bonus, to_char((pay*12)+bonus,'99,999')
from professor
where deptno = 101;


-- 5. NULL 처리 함수
--Professor 테이블에서 교수명, 급여, 보너스, 보너스인상을 출력한다
--단, 보너스 인상은(bouns*100)으로 하고, bonus가 없으면 0으로 처리
-- nvl2(column, 값1, 값2) : column 이 null이면 값2, null이 아니면 값1 수행
-- null 관련 함수 : nvl(column, 값), nvl2(column, 값1, 값2)
select name, pay, bonus, nvl2(bonus, bonus*100,0)
from professor
where deptno = 101;


-- 6. DECODE 함수
--Professor 테이블에서 deptno가 101번이면 학과명을
-- '컴퓨터 공학과' 아니면 ‘기타학과’로 출력하기
-- decode(필드명, 값, 참, 거짓)
select name, deptno,
decode(deptno,101,'컴퓨터공학과','기타학과')
from professor;



