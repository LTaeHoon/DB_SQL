--dataType.sql : Oracle 주요 자료형

create table student(
sid int primary key,       --학번 : 기본키(중복불가 + null 불가)
name varchar(25) not null, --이름 : null불가
phone varchar(30) unique,  --전화번호 : 중복불가, 생략가능
email char(50),            --이메일 : 고정길이, 생략가능
enter_date date not null   --입학년도 : 날짜 + 시간, null 불가
);

--테이블 목록 검색
select * from tab;

/*
 * Oracle 주요 자료형
 * 1. number(n) : n 크기 만큼 숫자(정수, 실수)
 * 2. int : 4byte 정수 저장
 * 3. varchar2(n) : n 크기 만큼 가변길이 문자 저장
 * 4. char(n) : n 크기 만큼 고정길이 문자 저장
 * 5. date : 날짜/시간 저장 - sysdate : system의 날짜/시산 저장
 *
 */

/*
 * 제약조건
 * 1. primary key : 해당 컬럼을 기본키로 지정(중복 불가 + null불가)
 * 2. not null : null값 허용 불가
 * 3. unique : 중복 불가(null 허용)
 */

/*
 * sequence?
 * - 시작값을 기준으로 일정한 값이 증가하는 객체
 * - 한번 삭제된 시퀀스 번호는 재생 불가
 * - 형식) create sequence 이름 increment by 증가값 start with 시작값;
 * - 삭제) drop sequence 이름;
 */
drop sequence 이름
create sequence seq_sid increment by 1 start with 1000;

-- sequence를 이용하여 학번 추가
insert into student values(seq_sid.nextval,'홍길동','010-1111-1111','hong@naver.com',sysdate);
insert into student values(seq_sid.nextval,'이순신','010-2222-1111','lee@naver.com',sysdate);
insert into student values(seq_sid.nextval,'강감찬','010-3333-1111','kang@naver.com',sysdate);
select * from student;

--db반영
commit work;
