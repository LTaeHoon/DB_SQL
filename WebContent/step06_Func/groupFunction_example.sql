--그룹함수(집계함수, 복수행함수)

--[1] count() : 레코드의 건수(개수)를 리턴
select count(*) from professor;     --레코드 전체 개수
select count(hpage) from professor; --null값은 제외하고 연산함
select count(bonus) from professor;
select count(name) from professor;

select * from professor;
--[2] sum(), avg() : 합계, 평균 구하는 함수
--문자, 날짜는 연산 불가능 => sum(), avg() 사용 불가
select sum(bonus), count(bonus) from professor;

--보너스 평균이 null값인 경우 0으로 하고 평균을 구하라?
select sum(bonus), avg(bonus), count(bonus), count(*),
avg(nvl(bonus,0))  from professor;
-- NVL(값1, 값2) : 값1이 NULL이면 값2, 아니면 값1 출력

--[3] max(),min()
--문자, 날짜도 비교연산은 가능 =>max(),min() 사용 가능
select max(pay), min(pay) from professor;


-- 분선/표준편차
select bonus from professor;
select variance(bonus) from professor;
select stddev(bonus) from professor;
select sqrt(variance(bonus)) from professor;

--[4] group by 범주형 칼럼
--동일 그룹별로 묶어서 그룹별 집계를 구한다.
select name, deptno, pay from professor
order by deptno;

select position, avg(PAY) from professor
group by position;

--학과별 교수의 급여(pay) 평균 구하기
select deptno, sum(pay), avg(pay) from professor
group by deptno;

-- nvl(pay,0) : pay가 null인 경우 0으로 치환
select position, avg(nvl(pay,0)) from professor
group by position;

/*
 * 조건절
 * 1. select * from <테이블명> where 조건식 order by 컬럼;
 * 2. select * from <테이블명> group by 칼럼명 having 조건식 order by 컬럼;
 */

--[5] having : group by의 결과에 대한 조건 정의
--group by의 결과에서 원하는 조건만 검색하고 싶을 때 사용
select deptno,avg(nvl(pay,0)) from professor
group by deptno
having avg(nvl(pay,0)) >=400;

--[실습1] group by의 결과에서 pay의 평균이 300미만인 경우만 조회

select deptno, avg(nvl(pay,0)) from professor
group by deptno
having avg(nvl(pay,0)) <300
order by deptno;

--[실습2] Student 테이블에서 grade별로 weight, height의 평균값, 최대값, 최소값 구하기
select grade,avg(weight), avg(height),max(weight),min(weight) from student
group by grade;


--[실습3] 몸무게 평균이 60이상인 경우만 검색
select grade, avg(weight) from student
group by grade
having avg(weight) >= 60
order by avg(weight) desc;


--rollup() - 주어진 데이터들의 소계를 구해주는 함수
select deptno, position, sum(pay), count(*)
from professor
group by rollup (deptno, position);
-- 같은 학과의 동일한 직급 교수에 대한 급여 소계





