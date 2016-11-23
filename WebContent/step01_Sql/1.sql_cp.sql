--- sql_cp.sql

/*
SQL : 구조화된 질의 언어
-DDL, DML, DCL
1. DDL : 데이터 정의어 -> DBA(관리자), USER(일반유저) (table 생성, 구조변경, 삭제)
2. DML : 데이터 조작어 -> USER (select, insert, update, delete)
3. DCL : 데이터 제어어 -> DBA (권한설정, 사용자 등록 등)

 */

--1. DDL : 데이터 정의어

--1) Table 생성
/*
 * create table 테이블명(
 *  칼럼명 데이터형 [제약조건],
 *  칼럼명 데이터형
 *  );
 *
 */
create table test2(
id varchar(20) primary key,
pwd varchar(30) not null,
name varchar(25) not null
);

--table 확인
select * from tab;  --scott 사용자의 전체 테이블
select * from test2;  -- 현재 테이블

--2) table 구조변경
--(1) 테이블 이름 변경
-- 형식) alter table 구테이블명 rename to 새테이블명;
alter table test2 rename to member;

--(2) 테이블 컬럼 추가
-- 형식) alter table 테이블명 add (칼럼명 자료형(n));
alter table member add (reg_date date);
select * from member;

--(3) 테이블 컬럼 수정 : type 수정
-- 형식) alter table 테이블명 modify (컬럼명 자료형(n) 제약조건);
alter table member modify (pwd varchar(50));

--(4) 테이블 컬럼 삭제
-- 형식) alter table 테이블명 drop column 칼럼명;
alter table member drop column reg_date;
select * from member;

--3) table 제거
-- 형식) drop table 테이블명 purge;
---purge속성 : 임시파일 제거
drop table member purge;
select * from tab;
purge recyclebin;

--2. DML : 데이터 조작어
create table depart(
dno number(4) primary key,
dname varchar(50),
daddress varchar(100)
);

--1) insert : 레코드 삽입
--형식) insert into 테이블명(컬럼명1,...,컬럼명n) values(값1,...,값n);
insert into depart (dno,dname,daddress) values(502,'기획실','서울시');
--전체 컬럼 대상인 경우 컬럼명 생략 가능
insert into depart values(1002,'영업부','대전시');

--2) select : 레코드 검색
-- 형식) select 컬럼명 from 테이블명 [where 조건식];
select * from depart;
select dno,daddress from depart;
select * from depart where dname='영업부';
select * from depart order by dno desc;

--3) update : 레코드 수정
-- 형식) update 테이블명 set 칼럼명 = 값 where 조건식;
update depart set dname='개발부' where dname='영업부';
update depart set dname='영업팀' where dno=1002;

--4)delete : 레코드 삭제
-- 형식) delete from 테이블명 where 조건식;
delete from depart where dno=1002;
delete from depart; -- 주의 : 조건식 생략시, 전체 레코드 삭제됨

drop table depart purge; --임시파일까지 삭제

--3. DCL : 데이터 제어어
--1) 권한 설정 : grant 권한, ... to user;
--2) 권한 해제 : revoke 권한,... to user;





