-- select_example.sql

select * from emp; -- * : 모든 컬럼을 의미
select empno,ename,sal from emp;  --특정 컬럼 조회

select empno,ename,sal,sal+500 from emp; -- 사칙연산

select empno,ename,sal,comm,sal+comm from emp; -- null 컬럼과 연산 시


select empno,ename,sal,comm,sal+NVL(comm,0) from emp; -- NVL 함수 처리 null값을 특정값으로 변환

select empno,ename,sal,comm,sal+NVL(comm,0) as 실급여 from emp; --별칭

select empno,ename||' '||(sal+nvl(comm,0)) as 실급여 from emp;  -- 컬럼과컬럼 연결자

select empno,ename||' '||(sal+nvl(comm,0)) as "실 급여" from emp; -- 별칭에 빈칸 있을 시 ""

select distinct job from emp; --중복 제거 출력

--<연습문제1>
select empno,ename,sal*12 연봉 from emp;

select * from emp;

select distinct empno from emp;

select ename||' '||job from emp;

select dname||' '||loc as "부서위치" from dept;

select job||' '||sal as "직위와급여" from emp;

--조건검색
select * from emp where sal>=2500;
SELECT empno, ename, job, sal, deptno FROM emp WHERE job = 'MANAGER';

select * from emp where hiredate <= to_date('1982/01/01', 'yyyy/mm/dd');
--to_data('문자열',format):문자열을 지정한 format으로 형변환 , 문자열 -> 날짜형

select ename, job, sal, deptno from emp where sal between 1300 and 1500;
select empno,ename,job,sal,hiredate from emp where empno in (7902,7788,7566);

select * from student;
select * from student where name like '서%';  -- 서로 시작하는 학생
select * from student where name like '%수';  --수로 끝나는 학생
select * from student where name like '%재%';  -- 처음, 중간, 끝 모두 포함

select empno,ename,job,sal,comm,deptno from emp where comm is null;     --수당을 못받는 사람
select empno,ename,job,sal,comm,deptno from emp where comm is not null; --수당을 받는 사람

-- 조건과 정렬 검색
select * from emp where comm is not null order by sal desc;



--<연습문제2>

select empno,ename,job,sal from emp where sal>=3000;
select ename,deptno from emp where empno=7788;
select ename,job,hiredate from emp where hiredate between to_date('1981/02/20','yyyy/mm/dd') and to_date('1981/05/01','yyyy/mm/dd') order by hiredate;
select * from emp where depno IN(10,20);
select deptno,ename employee,sal "Monthly Salary" from emp where sal>=1500 and deptno in(10,30);
select * from emp where hiredate >= to_date('1982/01/01','yyyy/mm/dd');
select * from emp where comm is not null;
select ename,sal,comm 보너스 from emp where comm>sal*0.1;
select * from emp where (job='CLERK' or job='ANALYST') AND sal not in(1000,3000,5000);
select * from emp where ename like '%LL%' and (deptno=30 or mgr=7782);
