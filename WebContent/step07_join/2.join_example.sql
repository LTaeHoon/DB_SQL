/*
 * 카티전 조인(Cartesian join)
 * - 테이블 간의 join 조건 없이 테이블을 연결하는 기법
 * [종류]
 * 1. inner join
 *  - 조인 대상의 테이블에 모두 데이터가 존재하는 경우
 * 2. outer join
 *  - 한쪽 테이블에만 데이터가 존재하는 경우
 */


-- 1. inner join
-- 학생(student)과 학과(department) 조인
-- 학생이름(s), 학과번호(s), 학과이름(d) 출력하시오.
select s.name, s.deptno1, d.dname
from STUDENT s, DEPARTMENT d
where s.deptno1 = d.deptno;

-- ANSI join(표준)
select s.name, deptno1, d.dname
from STUDENT s join DEPARTMENT d
on s.deptno1=d.deptno;

--[문제1]학생테이블(student)과 교수테이블(professor) 조인
-- 이름(s), 학과번호(s), 지도교수번호(s), 지도교수이름(p) 출력하시오.
select * from student;
select * from professor;

select s.name, s.deptno1, s.profno, p.name from student s, professor p
where s.profno = p.profno;

--[실습]학생테이블, 학과 테이블, 교수테이블 조인
--학생이름(s), 학과이름(d), 지도교수이름(p) 출력하시오.
--<3개 테이블 조인 조건>
--1) 학생과 학과 테이블 조인 필드
--학생 테이블 : 학과번호(deptno1)
--학과 테이블 : 학과번호(deptno)
--2) 학생과 교수 테이블 조인 필드
--학생 테이블 : 교수번호(profno)
--교수 테이블 : 교수번호(profno)
select s.name, d.dname as "학과명", p.name as"교수명"
from STUDENT s, DEPARTMENT d, PROFESSOR p
where s.deptno1=d.deptno and s.profno=p.profno;

--[문제2] 학생테이블, 교수테이블 조인
-- 학과번호(depton1)가 101번인 학생들의 학과번호(s), 학생이름(s),
-- 지도교수이름(p)을 출력하시오.
select s.deptno1, s.name as "학생명",p.name as "교수명" from student s,professor p
where s.profno = p.profno and s.deptno1=101;

-- 2. outer join
-- 한쪽 테이블에만 데이터가 존재하는 경우 사용되는 조인

--student 테이블과 professor 테이블을 조인하여 학생이름과
--지도교수 이름을 출력하시오.단, 지도교수가 결정되지 않은
-- 학생의 명단도 함께 출력하시오.(학생 데이터는 전부 출력)

-- 1) left outer join : 왼쪽 테이블 기준:학생 테이블 기준
select s.name as"학생이름", p.name as "교수이름"
from student s,professor p
where s.profno = p.profno;  -- 15


select s.name as"학생이름", p.name as "교수이름"
from student s,professor p
where s.profno = p.profno(+);  -- 21   15+6(null) =21
-- 기준이 왼쪽, 왼쪽 데이터는 전부 출력

-- ANSI join(표준)
select s.name, p.name
from student s left outer join professor p
on s.profno = p.profno;

-- 2) right outer join : 오른쪽 테이블 기준
--[실습] student 테이블과 professor 테이블을 조인하여
-- 학생이름과 지도교수 이름을 출력하시오.
-- 단, 지도학생이 결정되지 않은 교수의 명단도 함께 출력
select s.name as"학생이름", p.name as "교수이름"
from student s,professor p
where s.profno(+) = p.profno; -- 지도학생을 배정받지 못한 교수도 join
-- 기준이 오른쪽



