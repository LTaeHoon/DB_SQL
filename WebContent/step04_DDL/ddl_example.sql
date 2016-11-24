--ddl_example.sql

--1. 실수형 데이터 저장 테이블
create table EMP01(
empno number(4),
ename varchar(20),
sal number(7,2)  ---(전체,소수점)
);

insert into emp01 values(1,'홍길동',1234.12);
insert into emp01 values(2,'이순신',23334.12234);
insert into emp01 values(2,'이순신',123456.12345); --error : 전체 자릿수 over
select * from emp01;

--2. 서브쿼리 이용 테이블 생성
create table emp02
as
select * from emp;
select * from emp02;  -- 내용 + 구조 복사

--3. 특정 컬럼 이용 테이블 생성
create table emp03
as
select empno, ename from emp;

select * from emp03;

--4. 특정 레코드 이용 테이블 생성
create table emp04
as
select * from emp where sal >=2500;
select * from emp04;  -- 내용 + 구조 복사(특정 레코드)

--5. 구조 복사로 테이블 생성
drop table emp05 purge;
create table emp05
as
select empno,ename,sal from emp where 1=0; -- 조건식을 false로 지정
select * from emp05; -- 구조 복사 (레코드 없음)

--6. 외래키
create table dept_tab(
deptno number(2) primary key, --기본키 : 컬럼 레벨 제약 조적ㄴ
dname varchar(15),
loc varchar(50)
);

insert into dept_tab values(1,'영업부','서울');
insert into dept_tab values(2,'기획실','대전');
select * from dept_tab;

create table emp_tab(
empno number(4),
ename varchar(30),
sal number(7),
deptno number(2) not null,
foreign key(deptno) references dept_tab(deptno)
);

--외래키 : 다른 테이블의 기본키를 참조하는 컬럼

insert into emp_tab values(1001,'홍길동',2500000,1);
insert into emp_tab values(1002,'이순신',3000000,2);
insert into emp_tab values(1003,'유관순',2000000,3); -- 무결성 제약조건 : 외래키에 부모키에 없는 값을 쓰면 무결성 제약조건에 위배되어 에러가 난다.

select * from emp_tab;

--7. UNIQUE : 중복 불가, null 허용
create table uni_tab(
deptno number(2) unique,
dname varchar(20),
loc varchar(10)
);

insert into uni_tab values(01,'영업부','서울');
insert into uni_tab values(02,'기획실','서울');
insert into uni_tab values(02,'충무부','대전'); -- error
insert into uni_tab (dname, loc) values('회계부','광주');

select * from uni_tab;

--8. CHECK :
create table chk_tab(
deptno number(2) not null check(deptno in(10,20,30,40)),
dname varchar(20),
loc varchar(10)
);

insert into chk_tab values(10,'영업부','서울');
insert into chk_tab values(40,'회계부','대전');
insert into chk_tab values(50,'총무부','서울'); -error
select * from chk_tab;

--9. 전체 레코드 삭제
TRUNCATE TABLE chk_tab;
select * from chk_tab;
