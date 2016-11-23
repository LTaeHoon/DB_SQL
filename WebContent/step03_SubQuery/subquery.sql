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

