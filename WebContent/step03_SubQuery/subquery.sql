-- subquery.sql
/*
 형식1)
	main query
	as
	sub query;

형식2)
	main query 관계연산자 (sub query);
*/

-- deptno 칼럼으로 연결되어 있음
select * from emp;
select * from dept; -- 부서코드 테이블로 보면 됨

--형식1) 테이블 검색(sub) -> 테이블 생성(main)
create table dept01
as
select * from dept;
--dept(원본) -> dept01(사본)
select * from dept01;
insert into dept01 values(50,'ACCOUNTING','NEW YORK');

--형식2) main: DEPT, sub: EMP
select deptno,dname
from dept
where deptno = (select deptno from emp where ename='SCOTT');

--<실습1>

select ename, deptno
from emp
where deptno = (select deptno from emp where ename='SCOTT');

--<실습2>

select *
from emp
where mgr= (select mgr from emp where ename='SCOTT');

--<실습3>
select ename, sal
from emp
where sal >=(select sal from emp where ename='SCOTT');

---<실습4>
select ename, deptno
from emp
where deptno = (select deptno from dept01 where loc ='DALLAS');

--<실습5>
select ename,sal
from emp
where deptno =(select deptno from dept01 where dname='SALES');

-- 03.서브 쿼리에서 그룹 함수의 사용
select round(avg(sal),3) from emp;
select ename, sal
from emp
where sal > (select avg(sal) from emp);

-- 04. 다중 행 서브쿼리
--(1) IN 연산자
select ename, sal, deptno
from emp
where deptno in (select distinct deptno
from emp
where sal>=3000);

--<실습6>

select deptno, dname, loc
from dept01
where deptno in (select distinct deptno from emp where job='MANAGER')
order by deptno;

--(2) ALL 연산자 :서브 쿼리 최대값 이상
select ename, sal from emp where sal > all(select sal from emp where deptno =30);

--<실습7>
select ename, job, sal from emp where job !='SALESMAN' and sal > all(select sal from emp where job='SALESMAN');

--(3) ANY 연산자 :서브 쿼리 최소값 이상
select ename, sal from emp where sal >= any ( select sal from emp where deptno = 30 );

--<실습8>
select ename, job, sal from emp where job!='SALESMAN' and sal > any(select sal from emp where job='SALESMAN');