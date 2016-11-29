-- SQL Developer 에서 작업

-- table 생성 : 서브쿼리 사용
select * from dept;
create table dept_test
as
select * from dept;

select * from dept_test;

delete from dept_test where deptno=40;
savepoint c0;  -- c0 지점 생성
commit; -- commit work와 commit는 같음 -> DB 반영 , commit에 지점명 지정할 수 있음 -> commit to 지점명

delete from dept_test where deptno=30;

savepoint c1; -- c1 지점 생성
delete from dept_test where deptno=20;

savepoint c2;
delete from dept_test where deptno=10;

select * from dept_test;

rollback to c2;
select * from dept_test;

rollback to c1;

rollback to c0; -- 커밋 이전 작성된 c0는 작동 안함

rollback;
select * from dept_test;  -- 3개 레코드 복원(commit 이후 모두 복원)