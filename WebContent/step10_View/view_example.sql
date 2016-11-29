-- view_example.sql

--1.물리적 table 생성
create table db_view_table(
id varchar(15) primary key,
name varchar(20) not null,
email varchar(50),
regdate date not null
);

insert into DB_VIEW_TABLE values('hong','홍길동','hong@naver.com',sysdate);
insert into DB_VIEW_TABLE values('lee','이순신','lee@naver.com',to_date('20150410','YYYY-MM-DD'));
insert into DB_VIEW_TABLE values('admin','관리자','admin@naver.com',to_date('20120101','YYYY-MM-DD'));

select * from DB_VIEW_TABLE;
commit work;

-- 2. 가상테이블(view) 생성 : 서브쿼리 이용
create or replace view db_view
as
select * from db_view_table
where id ='admin' with read only;

-- with read only : 읽기 전용 view 생성(내용 수정 불가)

-- scott 사용자 view 생성 권한 : 관리자 모드 로그인
-- /as sysdba
-- grant create view to scott;

select * from db_view;
delete from db_view where id = 'admin';  -- 읽기 전용 뷰

-- scott 사용자 전체 테이블/뷰 목록
select * from tab;
-- scott 사용자 전체 테이블 목록
select * from user_tables;
-- scott 사용자 전체 뷰 목록
select * from user_views;

-- view 삭제
drop view db_view;

/*
 * view 사용 목적
 * 1. 복잡한 쿼리문을 단순화 시키는 목적
 * 2. 보안 목적 : 접근 권한에 따라서 서로 다르게 정보를 제공
 */

-- 1. 복잡한 쿼리문을 단순화 시키는 목적
select * from product;
select * from sale;

create or replace view join_view
as
select p.code, p.name, s.price, s.sdate
from product p,sale s
where p.code=s.code and p.name like '%기';

select * from join_view;

-- 2. 보안 목적

-- 1) 영업사원에게 제공하는 view(커미션 제공)
create or replace view sales_emp
as
select empno, ename, comm
from emp
where job ='SALESMAN';

select * from sales_emp;

-- 2) 일반사원에게 제공하는 뷰
create or replace view clerk_emp(사번,이름,직속상관,입사일,부서번호)
as
select empno, ename, mgr, hiredate, deptno
from emp
where job ='CLERK';

select * from clerk_emp;

-- 문제) 관리자용 뷰를 생성
-- view 이름 : manager_emp
-- 칼럼 : 전체 칼럼 (emp)
-- 조건 : 직책이 영업, 사원, 분석자 대상 읽기 전용
select * from emp;
create or replace view manager_emp
as
select * from emp
where job in ('SALESMAN','CLERK','ANALYST') with read only;

-- 의사컬럼 : rownum, 의사테이블 : dual
select * from emp;

select rownum, empno,ename,sal from emp; 
-- 행번호 : insert 순서에 의해서 결정

-- 입사일 순서대로 출력
select rownum, empno,ename,sal, hiredate 
from emp order by hiredate; 

-- 입사순 TOP-5 출력용 VIEW 생성
create or replace view top5_hire_view
as
select empno,ename,sal, hiredate 
from emp order by hiredate asc;

select * from top5_hire_view;
select rownum,empno,ename,sal,hiredate from top5_hire_view where rownum <=5;
-- 주의 : 의사컬럼 조건식 >,>= 사용조건 불가

--문제2) 급여를 많이 받는 순서대로 TOP3 조회 뷰를 생성하시오
--조건1> 물리적 테이블 : emp 테이블
--조건2> 뷰 이름 : sal_top3_view
--조건3> 대상 컬럼 : empno,ename,sal, hiredate

create or replace view sal_top3_view
as 
select empno,ename,sal,hiredate
from emp order by sal desc;

select rownum,empno,ename,sal,hiredate from sal_top3_view where rownum<=3;