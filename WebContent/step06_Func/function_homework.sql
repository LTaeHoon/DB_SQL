/*
 * 주요 함수
 * 작업 대상 테이블 : STUDENT, EMP, PROFESSOR
 */

--Q1. STUDENT 테이블에서 JUMIN 칼럼을 사용하여
-- 태어난 달이 8월인 사람의 이름과 생년월일 출력하기
-- 힌트 : substr() 함수 이용
select name, substr(jumin,1,6) from student
where substr(jumin,3,2)='08';

--Q2. EMP 테이블에서 사번이 홀수인 사람들을 검색하기
-- 힌트 : mod() 함수 이용
select * from emp
where mod(empno,2)!=0;


--Q3. Professor 테이블에서 교수명, 급여, 보너스, 연봉을 출력하기
-- 조건) 연봉 = pay*12+bonus 으로 계산, bonus가 없으면 급여 0 처리
-- 힌트 : nvl2() 함수 이용
select name 교수명, pay 급여, nvl2(bonus,bonus,0) 보너스, (pay*12+nvl2(bonus,bonus,0)) 연봉 from professor;



--Q4. Professor 테이블에서 교수명, 학과명을 출력하되
--  deptno가 101번이면 ‘컴퓨터 공학과’, 102번이면
-- ‘멀티미디어 공학과’, 103번이면 ‘소프트웨어 공학과’,
-- 나머지는 ‘기타학과’로 출력하기
-- decode()함수 이용
select name 교수명,deptno 학과명, decode(deptno,101,'컴퓨터 공학과',102,'멀티미디어 공학과',103,'소프트웨어 공학과','기타학과') 학과명 from PROFESSOR;



/*
 * 집합 함수(COUNT,MAX,MIN,SUM,AVG)
 * 작업 대상 테이블 : EMP, STUDENT, PROFESSOR
 */
--Q1. EMP 테이블에서 소속 부서별 최대 급여와 최소 급여 구하기
select deptno,max(sal),min(sal) from emp
group by deptno;

--Q2. EMP 테이블에서 JOB의 수 출력하기
select count(job) from emp;

--Q3. Professor 테이블에서 학과별,직위별 급여(pay) 평균 구하기
select deptno,position, avg(pay) from professor
group by rollup(deptno,position);


--Q4. Student 테이블에서 grade별로
-- weight, height의 평균값, 최대값, 최소값을 구한
-- 결과에서 키의 평균이 170 이하인 경우 구하기
select grade, avg(weight), avg(height), max(weight), max(height),min(weight),min(height) from student
group by grade
having avg(height) <=170;
