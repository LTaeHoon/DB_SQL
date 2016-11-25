-- dml_seq_example.sql

--<실습1> 구조복사 테이블 생성
create table sam01
as
select empno,ename,job,sal
from emp where 1=0;

select * from sam01;

--<실습2> 레코드 삽입
insert into sam01 values (1000,'APPLE','POLICE',10000);
insert into sam01 values (1010,'BANANA','NURSE',15000);
insert into sam01 values (1000,'ORANGE','DOCTOR',25000);

-- NULL 삽입 예
select * from dept01;

insert into dept01 values(60,null,'SEOUL'); -- 명시적
insert into dept01 (deptno,loc) values(70,'BUSAN'); -- 묵시적

--<실습3> NULL 갖는 레코드 추가
insert into sam01 values(1030,'VERY','',25000);
insert into sam01 values(1040,'CAT','',2000);

select * from sam01;

--서브쿼리 이용 레코드 추가
create table dept02  --테이블 생성(구조)
as
select * from dept where 1=0;

insert into dept02  --레코드 추가
select * from dept;

select * from dept02;

insert into sam01
select empno,ename,job,sal
from emp
where deptno=10;

select * from sam01;

--다중 테이블 레코드 삽입
create table emp_hir
as
select empno,ename,hiredate
from emp
where 1=0;

create table emp_mgr
as
select empno,ename,mgr
from emp
where 1=0;

select tname from tab;

insert all
into emp_hir values(empno, ename, hiredate)
into emp_mgr values(empno, ename, mgr)
select empno, ename, hiredate, mgr
from emp
where deptno=20;

select * from emp_hir;
select * from emp_mgr;

-- 레코드 수정
select * from emp01;
update emp01 set sal = sal * 1.1;

update emp01
set sal = sal * 1.1
where sal <= 1500;

--<실습5>
select * from sam01;
update sam01 set sal= sal-5000
where sal >= 10000;


-- 서브쿼리 이용 레코드 수정
UPDATE DEPT01
SET LOC=(SELECT LOC FROM DEPT01 WHERE DEPTNO=10)
WHERE DEPTNO=20;

--<실습6>
create table sam02
as
select ename,sal,hiredate,deptno
from emp
where 1=0;

--<실습7>
insert into sam02
select ename,sal,hiredate,deptno from emp;
select * from sam02;

update sam02
set sal=sal+1000
where deptno = (select deptno from dept where loc='DALLAS');

select * from sam02;

--<실습8>
select * from sam02;
update sam02
set (sal,hiredate)=(select sal,hiredate from emp where ename='KING');

--<실습9>
select * from sam01;

delete from sam01
where job is null;


-- sequence 다음값/현재값 확인
select seq_sid.nextval from dual; 
select seq_sid.currval from dual;